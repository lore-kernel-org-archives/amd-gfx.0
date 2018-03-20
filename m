From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Tue, 20 Mar 2018 10:51:52 -0400
Message-ID: <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <CAAxE2A5kq2oZtJRm2df1fjtb_p1m2_nvCmzv9y8mbO-GS8cGrw@mail.gmail.com>
 <BY1PR12MB0504183ED35A54559D22E041F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <f25ebe1d-0b19-e972-5eba-84570e625456@gmail.com>
 <BY1PR12MB05044A2A50F2580904C8AFB5F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2045032314=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li,
 Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2045032314==
Content-Type: multipart/alternative; boundary="001a11405f16735ff20567d9390b"

--001a11405f16735ff20567d9390b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 9:55 AM, Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Yes, exactly. And if I remember correctly Mesa used to always set GTT as
> fallback on APUs, correct?
>

"used to" is the key part. Mesa doesn't force GTT on APUs anymore. It
expects that the combination of BO priorities and BO move throttling will
result in optimal BO placements over time.

Marek


>
> The problem seems to be that this fallback isn't set for displayable BOs.
>
> So what needs to be done is to just enable this fallback for displayable
> BOs as well if the kernel can handle it.
>
> Christian.
>
>
> Am 20.03.2018 um 00:01 schrieb Marek Ol=C5=A1=C3=A1k:
>
> In theory, Mesa doesn't have to do anything. It can continue setting VRAM
> and if the kernel has to put a display buffer into GTT, it doesn't matter
> (for Mesa). Whether the VRAM placement is really used is largely determin=
ed
> by BO priorities.
>
> The way I understand scather/gather is that it only allows the GTT
> placement. It doesn't force the GTT placement. Mesa also doesn't force th=
e
> GTT placement.
>
> Marek
>
> On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org> wrote:
>> >>to my earlier point, there may be cases where it is advantageous to pu=
t
>> >> display buffers in vram even if s/g display is supported
>> >
>> > Agreed. That is also why the patch has the options to let user select
>> where
>> > to put display buffers.
>> >
>> > As whether to put the option in Mesa or kernel, it seems the differenc=
e
>> is
>> > not much. Also, since amdgpufb can request even without mesa, kernel
>> might
>> > be a better choice. In addition, putting in the kernel can save client=
=E2=80=99s
>> > duplicate work(mesa, ogl, vulkan, 2d, kernel=E2=80=A6)
>>
>> Why do we even expose different memory pools to the UMDs in the first
>> place ;)  Each pool has performance characteristics that may be
>> relevant for a particular work load.  Only the UMDs really know the
>> finer points of those workloads. In general, you don't want the kernel
>> dictating policy if you can avoid it.  The kernel exposes
>> functionality and userspace sets the policy.  With the location set in
>> userspace, each app/user can have whatever policy makes sense for
>> their use case all at the same time without needing to tweak their
>> kernel for every use case.
>>
>> Alex
>>
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--001a11405f16735ff20567d9390b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Mar 20, 2018 at 9:55 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.=
leichtzumerken@gmail.<wbr>com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_-3838486020630618689m_8572536124089128592moz-cite-prefi=
x">Yes, exactly. And if I remember
      correctly Mesa used to always set GTT as fallback on APUs,
      correct?<br></div></div></blockquote><div><br></div><div>&quot;used t=
o&quot; is the key part. Mesa doesn&#39;t force GTT on APUs anymore. It exp=
ects that the combination of BO priorities and BO move throttling will resu=
lt in optimal BO placements over time.<br><br></div><div>Marek<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" bgcolor=
=3D"#FFFFFF"><div class=3D"m_-3838486020630618689m_8572536124089128592moz-c=
ite-prefix">
      <br>
      The problem seems to be that this fallback isn&#39;t set for
      displayable BOs.<br>
      <br>
      So what needs to be done is to just enable this fallback for
      displayable BOs as well if the kernel can handle it.<span class=3D"m_=
-3838486020630618689HOEnZb"><font color=3D"#888888"><br>
      <br>
      Christian.</font></span><div><div class=3D"m_-3838486020630618689h5">=
<br>
      <br>
      Am 20.03.2018 um 00:01 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    </div></div></div>
    <blockquote type=3D"cite"><div><div class=3D"m_-3838486020630618689h5">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">In theory, Mesa doesn&#39;t have to do
            anything. It can continue setting VRAM and if the kernel has
            to put a display buffer into GTT, it doesn&#39;t matter (for
            Mesa). Whether the VRAM placement is really used is largely
            determined by BO priorities.<br>
          </div>
          <div class=3D"gmail_quote"><br>
          </div>
          <div class=3D"gmail_quote">The way I understand scather/gather
            is that it only allows the GTT placement. It doesn&#39;t force
            the GTT placement. Mesa also doesn&#39;t force the GTT
            placement.<br>
          </div>
          <div class=3D"gmail_quote"><br>
          </div>
          <div class=3D"gmail_quote">Marek<br>
          </div>
          <div class=3D"gmail_quote"><br>
          </div>
          <div class=3D"gmail_quote">On Mon, Mar 19, 2018 at 5:12 PM, Alex
            Deucher <span dir=3D"ltr">&lt;<a href=3D"mailto:alexdeucher@gma=
il.com" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>On
                Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel &lt;<a href=3D"mai=
lto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;
                wrote:<br>
                &gt;&gt;to my earlier point, there may be cases where it
                is advantageous to put<br>
                &gt;&gt; display buffers in vram even if s/g display is
                supported<br>
                &gt;<br>
                &gt; Agreed. That is also why the patch has the options
                to let user select where<br>
                &gt; to put display buffers.<br>
                &gt;<br>
                &gt; As whether to put the option in Mesa or kernel, it
                seems the difference is<br>
                &gt; not much. Also, since amdgpufb can request even
                without mesa, kernel might<br>
                &gt; be a better choice. In addition, putting in the
                kernel can save client=E2=80=99s<br>
                &gt; duplicate work(mesa, ogl, vulkan, 2d, kernel=E2=80=A6)=
<br>
                <br>
              </span>Why do we even expose different memory pools to the
              UMDs in the first<br>
              place ;)=C2=A0 Each pool has performance characteristics that
              may be<br>
              relevant for a particular work load.=C2=A0 Only the UMDs real=
ly
              know the<br>
              finer points of those workloads. In general, you don&#39;t
              want the kernel<br>
              dictating policy if you can avoid it.=C2=A0 The kernel expose=
s<br>
              functionality and userspace sets the policy.=C2=A0 With the
              location set in<br>
              userspace, each app/user can have whatever policy makes
              sense for<br>
              their use case all at the same time without needing to
              tweak their<br>
              kernel for every use case.<br>
              <span class=3D"m_-3838486020630618689m_8572536124089128592m_4=
947926278827078055HOEnZb"><font color=3D"#888888"><br>
                  Alex</font></span><br>
            </blockquote>
          </div>
        </div>
      </div>
      <br>
      <fieldset class=3D"m_-3838486020630618689m_8572536124089128592mimeAtt=
achmentHeader"></fieldset>
      <br>
      </div></div><span><pre>______________________________<wbr>___________=
______
amd-gfx mailing list
<a class=3D"m_-3838486020630618689m_8572536124089128592moz-txt-link-abbrevi=
ated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-g=
fx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"m_-3838486020630618689m_8572536124089128592moz-txt-link-freetex=
t" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
    </span></blockquote>
    <br>
  </div>

</blockquote></div><br></div></div>

--001a11405f16735ff20567d9390b--

--===============2045032314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2045032314==--
