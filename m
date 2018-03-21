From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 21 Mar 2018 14:23:48 -0400
Message-ID: <CAAxE2A7+18WdkiOOSD0E3PLed4nH2Bo3qGw85dAxD8AWpUkYCg@mail.gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
 <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>
 <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0@gmail.com>
 <DM5PR12MB18205326885F0857CEC4FAA6F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
 <7bbc4bc8-1b44-efc3-44b7-47ebcb4b9c76@amd.com>
 <CAAxE2A4gcwdGiApoh=sa-SMPtMpm6M2+LmvafhVVnW=kntPPKw@mail.gmail.com>
 <f1171a12-3092-6690-d6ae-c5e9869bce96@gmail.com>
 <CAAxE2A6xdScLAcuu3SpdnsJi-qJFr16BDxgYLvimFg1o8cNmpg@mail.gmail.com>
 <d2786617-d81f-e448-3cba-6f7dfeb521dc@amd.com>
 <CAAxE2A5d_iuT1dq3=KQav7JLuAUi38pJveEHsHMs7XsLJRoEYQ@mail.gmail.com>
 <4bc75e1a-ea91-6962-8a41-fd2b118c9cbb@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1192971127=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4bc75e1a-ea91-6962-8a41-fd2b118c9cbb-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li,
 Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1192971127==
Content-Type: multipart/alternative; boundary="001a113f97303e0c160567f04d6d"

--001a113f97303e0c160567f04d6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 2:15 PM, Christian K=C3=B6nig <christian.koenig@amd=
.com>
wrote:

> Am 21.03.2018 um 19:04 schrieb Marek Ol=C5=A1=C3=A1k:
>
> On Wed, Mar 21, 2018 at 10:07 AM, Christian K=C3=B6nig <
> christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> Am 21.03.2018 um 14:57 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> On Wed, Mar 21, 2018 at 4:13 AM, Christian K=C3=B6nig <
>> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>> Am 21.03.2018 um 06:08 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> On Tue, Mar 20, 2018 at 4:16 PM, Christian K=C3=B6nig <
>>> christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
>>>
>>>> That's what I meant with use up the otherwise unused VRAM. I don't see
>>>> any disadvantage of always setting GTT as second domain on APUs.
>>>>
>>>> My assumption was that we dropped this in userspace for displayable
>>>> surfaces, but Marek proved that wrong.
>>>>
>>>> So what we should do is actually to add GTT as fallback to all BOs on
>>>> APUs in Mesa and only make sure that the kernel is capable of handling=
 GTT
>>>> with optimal performance (e.g. have user huge pages etc..).
>>>>
>>>
>>> VRAM|GTT is practically as good as GTT. VRAM with BO priorities and
>>> eviction throttling is the true "VRAM|GTT".
>>>
>>> I don't know how else to make use of VRAM intelligently.
>>>
>>>
>>> Well why not set VRAM|GTT as default on APUs? That should still save
>>> quite a bunch of moves even with throttling.
>>>
>>
>> I explained why: VRAM|GTT is practically as good as GTT.
>>
>>
>>>
>>> I mean there really shouldn't be any advantage to use VRAM any more
>>> except that we want to use it up as long as it is available.
>>>
>>
>> Why are you suggesting to use VRAM|GTT then? Let's just only use GTT on
>> all APUs.
>>
>>
>> Then we don't use the memory stolen for VRAM.
>>
>> See we want to get to a point where we have any ~16MB of stolen VRAM on
>> APUs and everything else in GTT.
>>
>> But we still have to support cases where we have 1GB stolen VRAM, and
>> wasting those 1GB would suck a bit.
>>
>
> BO priorities and BO move throttling should take care of optimal VRAM
> usage regardless of the VRAM size. We can adjust the throttling for small
> VRAM, but that's about all we can do.
>
>
> Well at least on APUs move throttling is complete nonsense. VRAM should
> expose the same performance as GTT.
>
> So the only usage we have for VRAM is for special cases like page tables
> and to allow to actually use the stolen memory.
>
> VRAM|GTT doesn't guarantee that VRAM will be used usefully. In fact, it
> doesn't guarantee anything about VRAM.
>
>
> Why not? VRAM|GTT means that we should use VRAM as long as it is availabl=
e
> and if it is used up fallback to GTT.
>
> When BOs are evicted from VRAM they are never moved back into it. As far
> as I can see that is exactly what we need on APUs.
>

I see. You don't want to use VRAM usefully. You just want to fill it up
with something (anything) so that it's not unused.

Marek

--001a113f97303e0c160567f04d6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Mar 21, 2018 at 2:15 PM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koenig=
@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <div class=3D"m_7651348995298833062moz-cite-prefix">Am 21.03.2018 um 19=
:04 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Wed, Mar 21, 2018 at 10:07 AM,
            Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a href=3D"mailto:ch=
ristian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<=
/span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span>
                  <div class=3D"m_7651348995298833062m_1741296731872194054m=
oz-cite-prefix">Am
                    21.03.2018 um 14:57 schrieb Marek Ol=C5=A1=C3=A1k:<br>
                  </div>
                  <blockquote type=3D"cite">
                    <div dir=3D"ltr">
                      <div class=3D"gmail_extra">
                        <div class=3D"gmail_quote">On Wed, Mar 21, 2018 at
                          4:13 AM, Christian K=C3=B6nig <span dir=3D"ltr">&=
lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ck=
oenig.leichtzumerken@gmail.<wbr>com</a>&gt;</span>
                          wrote:<br>
                          <blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                            <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span=
>
                                <div class=3D"m_7651348995298833062m_174129=
6731872194054m_-1982752714132975532moz-cite-prefix">Am
                                  21.03.2018 um 06:08 schrieb Marek
                                  Ol=C5=A1=C3=A1k:<br>
                                </div>
                                <blockquote type=3D"cite">
                                  <div dir=3D"ltr">
                                    <div class=3D"gmail_extra">
                                      <div class=3D"gmail_quote">On Tue,
                                        Mar 20, 2018 at 4:16 PM,
                                        Christian K=C3=B6nig <span dir=3D"l=
tr">&lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">chris=
tian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                                        wrote:<br>
                                        <blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                                          <div text=3D"#000000" bgcolor=3D"=
#FFFFFF">
                                            <div class=3D"m_765134899529883=
3062m_1741296731872194054m_-1982752714132975532m_4643584645760816653moz-cit=
e-prefix">That&#39;s
                                              what I meant with use up
                                              the otherwise unused VRAM.
                                              I don&#39;t see any
                                              disadvantage of always
                                              setting GTT as second
                                              domain on APUs.<br>
                                              <br>
                                              My assumption was that we
                                              dropped this in userspace
                                              for displayable surfaces,
                                              but Marek proved that
                                              wrong.<br>
                                              <br>
                                              So what we should do is
                                              actually to add GTT as
                                              fallback to all BOs on
                                              APUs in Mesa and only make
                                              sure that the kernel is
                                              capable of handling GTT
                                              with optimal performance
                                              (e.g. have user huge pages
                                              etc..).<span class=3D"m_76513=
48995298833062m_1741296731872194054m_-1982752714132975532HOEnZb"><font colo=
r=3D"#888888"><br>
                                                </font></span></div>
                                          </div>
                                        </blockquote>
                                        <div><br>
                                        </div>
                                        <div>VRAM|GTT is practically as
                                          good as GTT. VRAM with BO
                                          priorities and eviction
                                          throttling is the true
                                          &quot;VRAM|GTT&quot;.<br>
                                          <br>
                                        </div>
                                        <div>I don&#39;t know how else to
                                          make use of VRAM
                                          intelligently.</div>
                                      </div>
                                    </div>
                                  </div>
                                </blockquote>
                                <br>
                              </span> Well why not set VRAM|GTT as
                              default on APUs? That should still save
                              quite a bunch of moves even with
                              throttling.<br>
                            </div>
                          </blockquote>
                          <div><br>
                          </div>
                          <div>I explained why: <span class=3D"m_7651348995=
298833062m_1741296731872194054gmail-">VRAM|GTT
                              is practically as good as GTT.</span><br>
                          </div>
                          <div>=C2=A0</div>
                          <blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                            <div text=3D"#000000" bgcolor=3D"#FFFFFF"> <br>
                              I mean there really shouldn&#39;t be any
                              advantage to use VRAM any more except that
                              we want to use it up as long as it is
                              available.<br>
                            </div>
                          </blockquote>
                          <div><br>
                          </div>
                          <div>Why are you suggesting to use VRAM|GTT
                            then? Let&#39;s just only use GTT on all APUs.<=
/div>
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <br>
                </span> Then we don&#39;t use the memory stolen for VRAM.<b=
r>
                <br>
                See we want to get to a point where we have any ~16MB of
                stolen VRAM on APUs and everything else in GTT.<br>
                <br>
                But we still have to support cases where we have 1GB
                stolen VRAM, and wasting those 1GB would suck a bit.<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            BO priorities and BO move throttling should take care of
            optimal VRAM usage regardless of the VRAM size. We can
            adjust the throttling for small VRAM, but that&#39;s about all
            we can do.</div>
        </div>
      </div>
    </blockquote>
    <br></span>
    Well at least on APUs move throttling is complete nonsense. VRAM
    should expose the same performance as GTT.<br>
    <br>
    So the only usage we have for VRAM is for special cases like page
    tables and to allow to actually use the stolen memory.<span class=3D"">=
<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">VRAM|GTT doesn&#39;t guarantee that VR=
AM
            will be used usefully. In fact, it doesn&#39;t guarantee
            anything about VRAM.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br></span>
    Why not? VRAM|GTT means that we should use VRAM as long as it is
    available and if it is used up fallback to GTT.<br>
    <br>
    When BOs are evicted from VRAM they are never moved back into it. As
    far as I can see that is exactly what we need on APUs.<br></div></block=
quote><div><br></div>I see. You don&#39;t want to use VRAM usefully. You ju=
st want to fill it up with something (anything) so that it&#39;s not unused=
.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Mare=
k<br></div></div></div>

--001a113f97303e0c160567f04d6d--

--===============1192971127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1192971127==--
