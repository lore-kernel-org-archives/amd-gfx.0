From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 16 Jan 2019 16:41:19 -0500
Message-ID: <CAAxE2A4aZiL-=PAj3DSP2rDhpT_D6_LK2hErofqi9SYmpJYo7Q@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <CAP+8YyFD+LxEQOLOY+mDC5v3OOyh1De2DcXK0sRtMW0t7z20SQ@mail.gmail.com>
 <74054b1e-5211-3bfc-ab0f-27e8604759d1@gmail.com>
 <CAAxE2A5ywFkNMtPbesU_kuSwKCmsPJ0D8wRFuSp14mpORcwYhg@mail.gmail.com>
 <a550562a-7d36-9acf-3143-217c507e667a@amd.com>
 <CAAxE2A4k8JtkrS2XfgRdmYY3NVR4ges=Yqfh-TH9O=LnaVv02g@mail.gmail.com>
 <3d525127-825b-efab-b0c8-76550634d1c1@gmail.com>
 <CAAxE2A77=9-qpfUmt-PQf5=Gx72SLZ5QvNaSYLJ9D6o0fiEz4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1569678901=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A77=9-qpfUmt-PQf5=Gx72SLZ5QvNaSYLJ9D6o0fiEz4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>

--===============1569678901==
Content-Type: multipart/alternative; boundary="0000000000009cf17f057f9a25fd"

--0000000000009cf17f057f9a25fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, I've pushed the patch because it helps simplify our the amdgpu winsys
code and I already have code that depends on it that I don't wanna rewrite.

Marek

On Wed, Jan 16, 2019 at 12:39 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:

> On Wed, Jan 16, 2019 at 9:43 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> Am 16.01.19 um 15:39 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>>
>>
>> On Wed, Jan 16, 2019, 9:34 AM Koenig, Christian <Christian.Koenig-urvtwAKJhsc@public.gmane.org=
m
>> wrote:
>>
>>> Am 16.01.19 um 15:31 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>>
>>>
>>> On Wed, Jan 16, 2019, 7:55 AM Christian K=C3=B6nig <
>>> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>>
>>>> Well if you ask me we should have the following interface for
>>>> negotiating memory management with the kernel:
>>>>
>>>> 1. We have per process BOs which can't be shared between processes.
>>>>
>>>> Those are always valid and don't need to be mentioned in any BO list
>>>> whatsoever.
>>>>
>>>> If we knew that a per process BO is currently not in use we can
>>>> optionally tell that to the kernel to make memory management more
>>>> efficient.
>>>>
>>>> In other words instead of a list of stuff which is used we send down t=
o
>>>> the kernel a list of stuff which is not used any more and that only
>>>> when
>>>> we know that it is necessary, e.g. when a game or application
>>>> overcommits.
>>>>
>>>
>>> Radeonsi doesn't use this because this approach caused performance
>>> degradation and also drops BO priorities.
>>>
>>>
>>> The performance degradation where mostly shortcomings with the LRU whic=
h
>>> by now have been fixed.
>>>
>>> BO priorities are a different topic, but could be added to per VM BOs a=
s
>>> well.
>>>
>>
>> What's the minimum drm version that contains the fixes?
>>
>>
>> I've pushed the last optimization this morning. No idea when it really
>> became useful, but the numbers from the closed source clients now look m=
uch
>> better.
>>
>> We should probably test and bump the drm version when we are sure that
>> this now works as expected.
>>
>
> We should, but AMD Mesa guys don't have any time.
>
> Marek
>

--0000000000009cf17f057f9a25fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>FYI, I&#39;ve pushed the patch because it helps simpl=
ify our the amdgpu winsys code and I already have code that depends on it t=
hat I don&#39;t wanna rewrite.</div><div><br></div><div>Marek<br></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail-m_66563595=
43614492672gmail_attr">On Wed, Jan 16, 2019 at 12:39 PM Marek Ol=C5=A1=C3=
=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">maraeo@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail-m_6656359543614492672gmail-m_-6109042771749129144gmail_attr">On Wed, J=
an 16, 2019 at 9:43 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.l=
eichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"gmail-m_6656359543614492672gmail-m_-6109042771749129144gm=
ail-m_1079118432294564707moz-cite-prefix">Am 16.01.19 um 15:39 schrieb Mare=
k
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div><br>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr">On Wed, Jan 16, 2019, 9:34 AM Koenig,
              Christian &lt;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" tar=
get=3D"_blank">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div class=3D"gmail-m_6656359543614492672gmail-m_-610904277=
1749129144gmail-m_1079118432294564707m_3799249069402976776moz-cite-prefix">=
Am
                  16.01.19 um 15:31 schrieb Marek Ol=C5=A1=C3=A1k:<br>
                </div>
                <blockquote type=3D"cite">
                  <div dir=3D"auto">
                    <div><br>
                      <br>
                      <div class=3D"gmail_quote">
                        <div dir=3D"ltr">On Wed, Jan 16, 2019, 7:55 AM
                          Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer" target=3D"_blank">ckoenig.le=
ichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          Well if you ask me we should have the
                          following interface for <br>
                          negotiating memory management with the kernel:<br=
>
                          <br>
                          1. We have per process BOs which can&#39;t be
                          shared between processes.<br>
                          <br>
                          Those are always valid and don&#39;t need to be
                          mentioned in any BO list <br>
                          whatsoever.<br>
                          <br>
                          If we knew that a per process BO is currently
                          not in use we can <br>
                          optionally tell that to the kernel to make
                          memory management more efficient.<br>
                          <br>
                          In other words instead of a list of stuff
                          which is used we send down to <br>
                          the kernel a list of stuff which is not used
                          any more and that only when <br>
                          we know that it is necessary, e.g. when a game
                          or application overcommits.<br>
                        </blockquote>
                      </div>
                    </div>
                    <div dir=3D"auto"><br>
                    </div>
                    <div dir=3D"auto">Radeonsi doesn&#39;t use this because
                      this approach caused performance degradation and
                      also drops BO priorities.</div>
                  </div>
                </blockquote>
                <br>
                The performance degradation where mostly shortcomings
                with the LRU which by now have been fixed.<br>
                <br>
                BO priorities are a different topic, but could be added
                to per VM BOs as well.<br>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">What&#39;s the minimum drm version that contains =
the
          fixes?</div>
      </div>
    </blockquote>
    <br>
    I&#39;ve pushed the last optimization this morning. No idea when it
    really became useful, but the numbers from the closed source clients
    now look much better.<br>
    <br>
    We should probably test and bump the drm version when we are sure
    that this now works as expected.<br></div></blockquote><div><br></div><=
div>We should, but AMD Mesa guys don&#39;t have any time.</div><div><br></d=
iv><div>Marek</div></div></div>
</blockquote></div>

--0000000000009cf17f057f9a25fd--

--===============1569678901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1569678901==--
