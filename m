From: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 10:51:14 +0100
Message-ID: <CAGtoiRhoigWeDHBUkB04AF7TUSGvhPTeWpVwhEpEXbULc=yr8w@mail.gmail.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <bca60368-969e-ff29-1342-432a48c23ffb@gmail.com>
 <CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ@mail.gmail.com>
 <e5ce02b3-a67c-d9d7-69ee-f66b5b82a2d7@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0602281827=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e5ce02b3-a67c-d9d7-69ee-f66b5b82a2d7-5C7GfCeVMHo@public.gmane.org>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0602281827==
Content-Type: multipart/alternative; boundary="001a114cde243017940565b5de3e"

--001a114cde243017940565b5de3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:31 AM, Christian K=C3=B6nig <christian.koenig@am=
d.com>
wrote:

> Am 21.02.2018 um 10:23 schrieb Bas Vermeulen:
>
> On Wed, Feb 21, 2018 at 10:14 AM, Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> Am 21.02.2018 um 10:06 schrieb Michel D=C3=A4nzer:
>>
>>> On 2018-02-21 09:49 AM, Bas Vermeulen wrote:
>>>
>>>> Hi,
>>>>
>>>> I am unsure if this is the right place to ask, but it seems relevant.
>>>>
>>>
>> Well this list is certainly the right place to ask :)
>
>
> That's what I was hoping for :)
>
>
>>
>> I am trying to use an AMD E8860 (SI) board connected to an E6500 PowerPC
>>>> board (T2080RDB from NXP).
>>>> The T2080RDB does not use a BIOS, and uses u-boot to bootstrap Linux.
>>>>
>>>> I have the E8860 connected to a PCIe x4 slot with an adapter. The kern=
el
>>>> is a 4.1, with DRM included in the kernel and the radeon as a module.
>>>> The radeon driver detects the card, notices the BIOS hasn't posted and
>>>> starts things up.
>>>> After that, the ring tests get run, and fails on the ring 0 test,
>>>> disabling acceleration. The graphics card is (or seems to be) working
>>>> apart from that, the driver starts up and sees the connectors on the
>>>> board.
>>>>
>>>> When I compare dmesg on an x86 machine and the PPC machine, I see that
>>>> the x86 machine loads a lot more firmware from the kernel (probably th=
e
>>>> acceleration parts?).
>>>>
>>> FWIW, that's probably just a subsequent symptom due to the ring test
>>> failure.
>>>
>>
>> Could be, but IIRC we load all the firmware first then initialize things
>> and then do the ring tests when we try to start the rings.
>>
>> BTW: What driver are you using? radeon or amdgpu?
>
>
> This is a south-island or sea-island chip, so using radeon.
>
>
> Well SI is also supported by amdgpu, I would give that a try as well.
>

Didn't know that,


> And BTW please try a more recent kernel as well, 4.1 is rather old.
>

Somewhat easier said than done; it's an NXP board, and they only supply 4.1
at the moment.
I'll see if I can upgrade to 4.15.x.


>
>
>
>
>>
>> My question is, what do I need to do to correctly initialize the E8860
>>>> board on my powerpc machine?
>>>>
>>> Start by sharing the dmesg output, and maybe also the kernel build
>>> configuration file.
>>>
>>
>> Maybe also open a bug report to attach the dmesg, see
>> bugs.freedesktop.org.
>>
>
> Sure. What project does the radeon driver fall under? I couldn't find the
> right category under Mesa, not sure what
> to file it under.
>
>
> Product DRI and then select DRM/Radeon as component.
>

Gotcha.

Bas Vermeulen

--001a114cde243017940565b5de3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Feb 21, 2018 at 10:31 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koeni=
g@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><div><div class=3D"h5">
    <div class=3D"m_4858667484013810028moz-cite-prefix">Am 21.02.2018 um 10=
:23 schrieb Bas
      Vermeulen:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Wed, Feb 21, 2018 at 10:14 AM,
            Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a href=3D"mailto:ck=
oenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerken@gm=
ail.<wbr>com</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>Am 21.02.2018 um 10:06 sch=
rieb Michel D=C3=A4nzer:<br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
                  On 2018-02-21 09:49 AM, Bas Vermeulen wrote:<br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
                    Hi,<br>
                    <br>
                    I am unsure if this is the right place to ask, but
                    it seems relevant.<br>
                  </blockquote>
                </blockquote>
                <br>
              </span>
              Well this list is certainly the right place to ask :)</blockq=
uote>
            <div><br>
            </div>
            <div>That&#39;s what I was hoping for :)</div>
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
                  <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
                    I am trying to use an AMD E8860 (SI) board connected
                    to an E6500 PowerPC<br>
                    board (T2080RDB from NXP).<br>
                    The T2080RDB does not use a BIOS, and uses u-boot to
                    bootstrap Linux.<br>
                    <br>
                    I have the E8860 connected to a PCIe x4 slot with an
                    adapter. The kernel<br>
                    is a 4.1, with DRM included in the kernel and the
                    radeon as a module.<br>
                    The radeon driver detects the card, notices the BIOS
                    hasn&#39;t posted and<br>
                    starts things up.<br>
                    After that, the ring tests get run, and fails on the
                    ring 0 test,<br>
                    disabling acceleration. The graphics card is (or
                    seems to be) working<br>
                    apart from that, the driver starts up and sees the
                    connectors on the board.<br>
                    <br>
                    When I compare dmesg on an x86 machine and the PPC
                    machine, I see that<br>
                    the x86 machine loads a lot more firmware from the
                    kernel (probably the<br>
                    acceleration parts?).<br>
                  </blockquote>
                  FWIW, that&#39;s probably just a subsequent symptom due t=
o
                  the ring test<br>
                  failure.<br>
                </blockquote>
                <br>
              </span>
              Could be, but IIRC we load all the firmware first then
              initialize things and then do the ring tests when we try
              to start the rings.<br>
              <br>
              BTW: What driver are you using? radeon or amdgpu?</blockquote=
>
            <div><br>
            </div>
            <div>This is a south-island or sea-island chip, so using
              radeon.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br></div></div>
    Well SI is also supported by amdgpu, I would give that a try as
    well.<br></div></blockquote><div><br></div><div>Didn&#39;t know that,</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" b=
gcolor=3D"#FFFFFF">
    And BTW please try a more recent kernel as well, 4.1 is rather old.</di=
v></blockquote><div><br></div><div>Somewhat easier said than done; it&#39;s=
 an NXP board, and they only supply 4.1 at the moment.</div><div>I&#39;ll s=
ee if I can upgrade to 4.15.x.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D""><br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
                  <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
                    My question is, what do I need to do to correctly
                    initialize the E8860<br>
                    board on my powerpc machine?<br>
                  </blockquote>
                  Start by sharing the dmesg output, and maybe also the
                  kernel build<br>
                  configuration file.<br>
                </blockquote>
                <br>
              </span>
              Maybe also open a bug report to attach the dmesg, see <a href=
=3D"http://bugs.freedesktop.org" rel=3D"noreferrer" target=3D"_blank">bugs.=
freedesktop.org</a>.<br>
            </blockquote>
            <div><br>
            </div>
            <div>Sure. What project does the radeon driver fall under? I
              couldn&#39;t find the right category under Mesa, not sure wha=
t</div>
            <div>to file it under.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br></span>
    Product DRI and then select DRM/Radeon as component.<br></div></blockqu=
ote><div><br></div><div>Gotcha.</div><div><br></div><div>Bas Vermeulen</div=
><div><br></div></div></div></div>

--001a114cde243017940565b5de3e--

--===============0602281827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0602281827==--
