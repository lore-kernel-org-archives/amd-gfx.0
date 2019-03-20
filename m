From: Stephen Hines <srhines-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Date: Wed, 20 Mar 2019 07:58:09 -0700
Message-ID: <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
References: <20190320005406.GA16412@archlinux-ryzen>
 <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen>
 <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1664731403=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <63518f1f-b808-77b0-aac6-ee1ece669c4b-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Pan,
 Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============1664731403==
Content-Type: multipart/alternative; boundary="00000000000041418c058487da06"

--00000000000041418c058487da06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Why are there 2 different enums for this same thing at all? By casting, you
are reducing type safety in the kernel, which can cause bugs later (should
the two enums diverge in encoding). In my opinion, the proper solution is
to remove one of the enums or provide an explicit helper that does the
conversion (along with assertions for handling any unexpected cases). The
helper function should not be doing a direct cast, since a bug could change
the integer value of one (or both) of these enums so that they don't match
up.

Thanks,
Steve

On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org=
>
wrote:

> Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
> > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> >> these two enumerated types are same for now. both of them might change
> in the future.
> >>
> >> I have not used clang, but would  .block_id =3D  (int)head->block fix
> your warning? If such change is acceptable, I can make one then.
> >>
> >> Thanks
> >> xinhui
> >>
> >>
> >> -----Original Message-----
> >> From: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Sent: 2019=E5=B9=B43=E6=9C=8820=E6=97=A5 8:54
> >> To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian =
<
> Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>;
> Pan, Xinhui <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
> >> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
> >> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >>
> >> Hi all,
> >>
> >> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add
> amdgpu_ras.c to support ras (v2)") introduces the following Clang
> >> warnings:
> >>
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_block' to different
> enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> >>                          .block_id =3D  head->block,
> >>                                       ~~~~~~^~~~~
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_error_type' to differen=
t
> enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> >>                          .error_type =3D head->type,
> >>                                        ~~~~~~^~~~
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_block' to different
> enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> >>                          .block_id =3D  head->block,
> >>                                       ~~~~~~^~~~~
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_error_type' to differen=
t
> enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> >>                          .error_type =3D head->type,
> >>                                        ~~~~~~^~~~
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_block' to different
> enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> >>                  .block_id =3D info->head.block,
> >>                              ~~~~~~~~~~~^~~~~
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_error_type' to differen=
t
> enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> >>                  .inject_error_type =3D info->head.type,
> >>                                       ~~~~~~~~~~~^~~~
> >> 6 warnings generated.
> >>
> >> Normally, I would sent a fix for this myself but I am not entirely sur=
e
> why these two enumerated types exist when one would do since they have th=
e
> same values minus the prefix. In fact, the ta_ras_{block,error_type} valu=
es
> are never used aside from being defined. Some clarification would be
> appreciated.
> >>
> >> Thank you,
> >> Nathan
> > Hi Xinhui,
> >
> > Yes, explicitly casting these six spots to int would resolve this
> > warning.
>
> Another question is if it is such a good idea to just silence the warning=
?
>
> Maybe add a amdgpu_ras_error_to_ta() helper to do this casting?
>
> When the enums drift away from each other then we can still add warnings
> to that helper to make sure we don't accidentally cast invalid values
> around.
>
> Regards,
> Christian.
>
> >
> > Thank you for the quick response!
> > Nathan
>
> --
> You received this message because you are subscribed to the Google Groups
> "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to clang-built-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> To post to this group, send email to clang-built-linux-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/clang-built-linux/63518f1f-b808-77b0-aa=
c6-ee1ece669c4b%40amd.com
> .
> For more options, visit https://groups.google.com/d/optout.
>

--00000000000041418c058487da06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Why are there 2 different enums for this same thing at all=
? By casting, you are reducing type safety in the kernel, which can cause b=
ugs later (should the two enums diverge in encoding). In my opinion, the pr=
oper solution is to remove one of the enums or provide an explicit helper t=
hat does the conversion (along with assertions for handling any unexpected =
cases). The helper function should not be doing a direct cast, since a bug =
could change the integer value of one (or both) of these enums so that they=
 don&#39;t match up.<div><br></div><div>Thanks,</div><div>Steve</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Mar 20, 2019 at 2:37 AM Koenig, Christian &lt;<a href=3D"mailto:Christian=
.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Am 20.03.19 um 05:34 schrieb Natha=
n Chancellor:<br>
&gt; On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:<br>
&gt;&gt; these two enumerated types are same for now. both of them might ch=
ange in the future.<br>
&gt;&gt;<br>
&gt;&gt; I have not used clang, but would=C2=A0 .block_id =3D=C2=A0 (int)he=
ad-&gt;block fix your warning? If such change is acceptable, I can make one=
 then.<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt; xinhui<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Nathan Chancellor &lt;<a href=3D"mailto:natechancellor@gmail=
.com" target=3D"_blank">natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; Sent: 2019=E5=B9=B43=E6=9C=8820=E6=97=A5 8:54<br>
&gt;&gt; To: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd=
.com" target=3D"_blank">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Koenig, Christia=
n &lt;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Christi=
an.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;; Zhou, David(ChunMing) &lt;<a href=3D"mailto:Davi=
d1.Zhou-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">David1.Zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;; Pan, Xinhui=
 &lt;<a href=3D"mailto:Xinhui.Pan-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Xinhui.Pan@amd=
.com</a>&gt;<br>
&gt;&gt; Cc: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_bl=
ank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; <a href=3D"mailto:dri-devel@lists.f=
reedesktop.org" target=3D"_blank">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; <a h=
ref=3D"mailto:linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_blank">linux-kernel@=
vger.kernel.org</a>; <a href=3D"mailto:clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" =
target=3D"_blank">clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a><br>
&gt;&gt; Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<=
br>
&gt;&gt;<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; The introduction of this file in commit dbd249c24427 (&quot;drm/am=
dgpu: add amdgpu_ras.c to support ras (v2)&quot;) introduces the following =
Clang<br>
&gt;&gt; warnings:<br>
&gt;&gt;<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit =
conversion from enumeration type &#39;enum amdgpu_ras_block&#39; to differe=
nt enumeration type &#39;enum ta_ras_block&#39; [-Wenum-conversion]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .block_id =3D=C2=A0 head-&gt;block,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
~~~~^~~~~<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit =
conversion from enumeration type &#39;enum amdgpu_ras_error_type&#39; to di=
fferent enumeration type &#39;enum ta_ras_error_type&#39; [-Wenum-conversio=
n]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .error_type =3D head-&gt;type,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~^~~~<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit =
conversion from enumeration type &#39;enum amdgpu_ras_block&#39; to differe=
nt enumeration type &#39;enum ta_ras_block&#39; [-Wenum-conversion]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .block_id =3D=C2=A0 head-&gt;block,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
~~~~^~~~~<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit =
conversion from enumeration type &#39;enum amdgpu_ras_error_type&#39; to di=
fferent enumeration type &#39;enum ta_ras_error_type&#39; [-Wenum-conversio=
n]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .error_type =3D head-&gt;type,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~=
~~~~~^~~~<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit =
conversion from enumeration type &#39;enum amdgpu_ras_block&#39; to differe=
nt enumeration type &#39;enum ta_ras_block&#39; [-Wenum-conversion]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .blo=
ck_id =3D info-&gt;head.block,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~^~~~~<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit =
conversion from enumeration type &#39;enum amdgpu_ras_error_type&#39; to di=
fferent enumeration type &#39;enum ta_ras_error_type&#39; [-Wenum-conversio=
n]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .inj=
ect_error_type =3D info-&gt;head.type,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
~~~~~~~~~^~~~<br>
&gt;&gt; 6 warnings generated.<br>
&gt;&gt;<br>
&gt;&gt; Normally, I would sent a fix for this myself but I am not entirely=
 sure why these two enumerated types exist when one would do since they hav=
e the same values minus the prefix. In fact, the ta_ras_{block,error_type} =
values are never used aside from being defined. Some clarification would be=
 appreciated.<br>
&gt;&gt;<br>
&gt;&gt; Thank you,<br>
&gt;&gt; Nathan<br>
&gt; Hi Xinhui,<br>
&gt;<br>
&gt; Yes, explicitly casting these six spots to int would resolve this<br>
&gt; warning.<br>
<br>
Another question is if it is such a good idea to just silence the warning?<=
br>
<br>
Maybe add a amdgpu_ras_error_to_ta() helper to do this casting?<br>
<br>
When the enums drift away from each other then we can still add warnings <b=
r>
to that helper to make sure we don&#39;t accidentally cast invalid values <=
br>
around.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Thank you for the quick response!<br>
&gt; Nathan<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;Clang Built Linux&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:clang-built-linux%2Bunsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org"=
 target=3D"_blank">clang-built-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br>
To post to this group, send email to <a href=3D"mailto:clang-built-linux@go=
oglegroups.com" target=3D"_blank">clang-built-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<b=
r>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/clang-built-linux/63518f1f-b808-77b0-aac6-ee1ece669c4b%40amd.com=
" rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/msgid/cl=
ang-built-linux/63518f1f-b808-77b0-aac6-ee1ece669c4b%40amd.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" rel=
=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/optout</a>.<b=
r>
</blockquote></div>

--00000000000041418c058487da06--

--===============1664731403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1664731403==--
