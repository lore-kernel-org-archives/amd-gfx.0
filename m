From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 9 Jan 2019 18:39:31 -0500
Message-ID: <CAAxE2A5RjR=+2Rs5HDx1rV0ftdkZJX=6TQDkvRQSxfo++vnXOA@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
 <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
 <513ee137-7e99-c8fc-9e3b-e9077ead60a3@gmail.com>
 <CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ@mail.gmail.com>
 <7f85afd6-b17b-1c50-ba03-c03dd6e9a362@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208134913=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7f85afd6-b17b-1c50-ba03-c03dd6e9a362-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1208134913==
Content-Type: multipart/alternative; boundary="0000000000007a2198057f0efbc3"

--0000000000007a2198057f0efbc3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 9, 2019 at 1:41 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 09.01.19 um 17:14 schrieb Marek Ol=C5=A1=C3=A1k:
>
> On Wed, Jan 9, 2019 at 8:09 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> Am 09.01.19 um 13:36 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>>
>>
>> On Wed, Jan 9, 2019, 5:28 AM Christian K=C3=B6nig <
>> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>
>>> Looks good, but I'm wondering what's the actual improvement?
>>>
>>
>> No malloc calls and 1 less for loop copying the bo list.
>>
>>
>> Yeah, but didn't we want to get completely rid of the bo list?
>>
>
> If we have multiple IBs (e.g. gfx + compute) that share a BO list, I thin=
k
> it's faster to send the BO list to the kernel only once.
>
>
> That's not really faster.
>
> The only thing we safe us is a single loop over all BOs to lockup the
> handle into a pointer and that is only a tiny fraction of the overhead.
>
> The majority of the overhead is locking the BOs and reserving space for
> the submission.
>
> What could really help here is to submit gfx+comput together in just one
> CS IOCTL. This way we would need the locking and space reservation only
> once.
>
> It's a bit of work in the kernel side, but certainly doable.
>

OK. Any objections to this patch?

Thanks,
Marek

--0000000000007a2198057f0efbc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"></div><div dir=
=3D"ltr">On Wed, Jan 9, 2019 at 1:41 PM Christian K=C3=B6nig &lt;<a href=3D=
"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"gmail-m_-7810855682144448022moz-cite-prefix">Am 09.01.19 =
um 17:14 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div dir=3D"ltr">On Wed, Jan 9, 2019 at 8:09 AM Christian
              K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail=
.com" target=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div class=3D"gmail-m_-7810855682144448022m_893090899402720=
7900m_-7323258551939539738gmail-m_4443106390953893387gmail-m_-3252015337124=
169842moz-cite-prefix">Am
                  09.01.19 um 13:36 schrieb Marek Ol=C5=A1=C3=A1k:<br>
                </div>
                <blockquote type=3D"cite">
                  <div dir=3D"auto">
                    <div><br>
                      <br>
                      <div class=3D"gmail_quote">
                        <div dir=3D"ltr">On Wed, Jan 9, 2019, 5:28 AM
                          Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerken@gmail.=
com</a>
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">L=
ooks good,
                          but I&#39;m wondering what&#39;s the actual
                          improvement?<br>
                        </blockquote>
                      </div>
                    </div>
                    <div dir=3D"auto"><br>
                    </div>
                    <div dir=3D"auto">No malloc calls and 1 less for loop
                      copying the bo list.</div>
                  </div>
                </blockquote>
                <br>
                Yeah, but didn&#39;t we want to get completely rid of the b=
o
                list?<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            If we have multiple IBs (e.g. gfx + compute) that share a BO
            list, I think it&#39;s faster to send the BO list to the kernel
            only once.</div>
        </div>
      </div>
    </blockquote>
    <br>
    That&#39;s not really faster.<br>
    <br>
    The only thing we safe us is a single loop over all BOs to lockup
    the handle into a pointer and that is only a tiny fraction of the
    overhead.<br>
    <br>
    The majority of the overhead is locking the BOs and reserving space
    for the submission.<br>
    <br>
    What could really help here is to submit gfx+comput together in just
    one CS IOCTL. This way we would need the locking and space
    reservation only once.<br>
    <br>
    It&#39;s a bit of work in the kernel side, but certainly doable.<br></d=
iv></blockquote><div><br></div><div>OK. Any objections to this patch?</div>=
<div><br></div><div>Thanks,<br></div><div>Marek</div></div></div>

--0000000000007a2198057f0efbc3--

--===============1208134913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1208134913==--
