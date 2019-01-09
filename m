From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 9 Jan 2019 11:14:13 -0500
Message-ID: <CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
 <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
 <513ee137-7e99-c8fc-9e3b-e9077ead60a3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0900216020=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <513ee137-7e99-c8fc-9e3b-e9077ead60a3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============0900216020==
Content-Type: multipart/alternative; boundary="000000000000de09fe057f08c2d4"

--000000000000de09fe057f08c2d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 9, 2019 at 8:09 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 09.01.19 um 13:36 schrieb Marek Ol=C5=A1=C3=A1k:
>
>
>
> On Wed, Jan 9, 2019, 5:28 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>
>> Looks good, but I'm wondering what's the actual improvement?
>>
>
> No malloc calls and 1 less for loop copying the bo list.
>
>
> Yeah, but didn't we want to get completely rid of the bo list?
>

If we have multiple IBs (e.g. gfx + compute) that share a BO list, I think
it's faster to send the BO list to the kernel only once.

Marek

--000000000000de09fe057f08c2d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"lt=
r">On Wed, Jan 9, 2019 at 8:09 AM Christian K=C3=B6nig &lt;<a href=3D"mailt=
o:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerke=
n@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"m_8930908994027207900m_-7323258551939539738gmail-m_444310=
6390953893387gmail-m_-3252015337124169842moz-cite-prefix">Am 09.01.19 um 13=
:36 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div><br>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr">On Wed, Jan 9, 2019, 5:28 AM Christian K=C3=B6=
nig
              &lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targe=
t=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Looks
              good, but I&#39;m wondering what&#39;s the actual improvement=
?<br>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">No malloc calls and 1 less for loop copying the
          bo list.</div>
      </div>
    </blockquote>
    <br>
    Yeah, but didn&#39;t we want to get completely rid of the bo list?<br><=
/div></blockquote><div><br></div>If we have multiple IBs (e.g. gfx + comput=
e) that share a BO list, I think it&#39;s faster to send the BO list to the=
 kernel only once.</div><div class=3D"gmail_quote"><br></div><div class=3D"=
gmail_quote">Marek<br></div></div></div>

--000000000000de09fe057f08c2d4--

--===============0900216020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0900216020==--
