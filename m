From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/14] amdgpu: powerplay: Remove unused function
Date: Wed, 26 Jul 2017 15:46:48 +0200
Message-ID: <CAPybu_3Z+3fGyMvyCbAk6c6=dkgEKN1me9_nSOvO8wjS2tWxsg@mail.gmail.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
 <20170724133540.32200-2-ricardo.ribalda@gmail.com>
 <40ac5a58-9e02-0240-ae87-0b1c9375873b@amd.com>
 <CAPybu_2eqTsFzrP=o8u-m-sCi-VDx6Bep2AqT7KGH4p6LstHcA@mail.gmail.com>
 <a059f078-b364-e0b7-6532-99fa4d36514e@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723101497=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a059f078-b364-e0b7-6532-99fa4d36514e-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0723101497==
Content-Type: multipart/alternative; boundary="001a113bce362b6534055538af62"

--001a113bce362b6534055538af62
Content-Type: text/plain; charset="UTF-8"

Hi Harry

On Mon, Jul 24, 2017 at 5:45 PM, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
wrote:

> On 2017-07-24 10:06 AM, Ricardo Ribalda Delgado wrote:
> > Hi Harry
> > On Mon, Jul 24, 2017 at 4:01 PM, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> wrote:
> >
> >>
> >> This is used and needed by the DC display driver. See
> >> display/amdgpu_dm/amdgpu_dm_services.c:193 in Alex's amd-staging-4.11
> tree:
> >>
> >> https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/
> drm/amd/display/amdgpu_dm/amdgpu_dm_services.c?h=amd-staging-4.11
> >>
> >
> > I could not find any reference to the function in linux-next (>4.12)
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/
> linux-next.git/tree/drivers/gpu/drm/amd
> >
> > Is there any plan to merge Alex's amd-stagin tree?
>
> The plan is to merge/upstream the amd/display portion of Alex's
> amd-staging tree. We're currently working on the community feedback we
> received to get it into shape.
>


Is there any timeframe for this?

 At least we should remove the   pr_info("min_core_set_clock not set\n");
message.

it is (very) misleading right now.

Regards!


> Harry
>
> >
> > Sorry, I am not very familiar with this subsystem.
> >
> > Regards!
> >
>



-- 
Ricardo Ribalda

--001a113bce362b6534055538af62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Harry<div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Mon, Jul 24, 2017 at 5:45 PM, Harry Wentland <span dir=3D"ltr">&=
lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">harry.wentla=
nd-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"gmail-">On 2017-07-24 10:06 AM, Ricardo Ribalda D=
elgado wrote:<br>
&gt; Hi Harry<br>
&gt; On Mon, Jul 24, 2017 at 4:01 PM, Harry Wentland &lt;<a href=3D"mailto:=
harry.wentland-5C7GfCeVMHo@public.gmane.org">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; This is used and needed by the DC display driver. See<br>
&gt;&gt; display/amdgpu_dm/amdgpu_dm_<wbr>services.c:193 in Alex&#39;s amd-=
staging-4.11 tree:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c?h=3Damd-staging-4.11" re=
l=3D"noreferrer" target=3D"_blank">https://cgit.freedesktop.org/~<wbr>agd5f=
/linux/tree/drivers/gpu/<wbr>drm/amd/display/amdgpu_dm/<wbr>amdgpu_dm_servi=
ces.c?h=3Damd-<wbr>staging-4.11</a><br>
&gt;&gt;<br>
&gt;<br>
&gt; I could not find any reference to the function in linux-next (&gt;4.12=
)<br>
&gt;<br>
&gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git/tree/drivers/gpu/drm/amd" rel=3D"noreferrer" target=3D"_blank">htt=
ps://git.kernel.org/pub/<wbr>scm/linux/kernel/git/next/<wbr>linux-next.git/=
tree/drivers/<wbr>gpu/drm/amd</a><br>
&gt;<br>
&gt; Is there any plan to merge Alex&#39;s amd-stagin tree?<br>
<br>
</span>The plan is to merge/upstream the amd/display portion of Alex&#39;s<=
br>
amd-staging tree. We&#39;re currently working on the community feedback we<=
br>
received to get it into shape.<br></blockquote><div><br></div><div><br></di=
v><div>Is there any timeframe for this?</div><div><br></div><div>=C2=A0At l=
east we should remove the =C2=A0 pr_info(&quot;min_core_set_clock not set\n=
&quot;); message.</div><div><br></div><div>it is (very) misleading right no=
w.</div><div><br></div><div>Regards!</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
Harry<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt;<br>
&gt; Sorry, I am not very familiar with this subsystem.<br>
&gt;<br>
&gt; Regards!<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Ricardo Ribalda</div>
</div></div>

--001a113bce362b6534055538af62--

--===============0723101497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0723101497==--
