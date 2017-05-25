From: Subrat Meher <smeher02.aoe3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Topics for beginners
Date: Thu, 25 May 2017 11:59:45 +0800
Message-ID: <CAMw8iYpuzY7_DZLtHOiF+ZFrh9fizOrOF6fdVZUuh04xKkvh6Q@mail.gmail.com>
References: <CAMw8iYqLAd=JK693F-bL_1MTaznX4VXzhA0t56h508SZdgo9BQ@mail.gmail.com>
 <CAMw8iYpZqKi+LN5Lo8NT-Rqg42z9ewBw4X+n3Jj6qbCkceUd5g@mail.gmail.com>
 <CAMw8iYroM5kBRYzLJdqNR8asOv3Bt5w2EtaneP1QAGDdcJ03=g@mail.gmail.com>
 <CAMw8iYq7F-fc8QKD-A+iqUajj7nL4p62YdpP29dxhKaRRRDecQ@mail.gmail.com>
 <CAMw8iYpQ83xw5U6LyAoZ+efuqM-b-7uwUVTwbrPz4FtFi2bHUg@mail.gmail.com>
 <CAMw8iYrmqjxKxcBJgfyzjT2JBzChYkRBKW=pBy4gHBsZgRRX4g@mail.gmail.com>
 <CAMw8iYov6gfOqaJ9Hymc81TPbHJU9YC4Me9_6YArb8vyEjjGZw@mail.gmail.com>
 <CAMw8iYoH96pdaGWR=xr1j5sk7zMJOdwUZ7gE6AoBcPTsme=Gwg@mail.gmail.com>
 <CAMw8iYroyTGtkSZDt0ro+aO-A-22q805gEE8fJsaV+vmJ0wvNg@mail.gmail.com>
 <CAMw8iYrahVpJ3MiiGCgw4Ev6SCypeixrWBeoTDhrqpG+VGD00Q@mail.gmail.com>
 <CAMw8iYrxV2L+cXaSXwtvwgpX8cia+at4Q5eNSkWEYf7Dtt-uQg@mail.gmail.com>
 <CAMw8iYqQ+fhdOorVEnHA6S=PXSH58V+PGNZ2BPSEssEY4qaNaQ@mail.gmail.com>
 <CAMw8iYqhkCgmduqpVJY3gj_=g5_CKUrSMxVygJvsZT+u-cyKuA@mail.gmail.com>
 <CAMw8iYqswbvJs9bGobef81CR0rqx0jxLM=JFpMyFC9TNpFDhZQ@mail.gmail.com>
 <d549afe3-63af-a3d9-ce14-426ffad9e979@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0312405236=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d549afe3-63af-a3d9-ce14-426ffad9e979-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0312405236==
Content-Type: multipart/alternative; boundary="001a113ce5be60078e0550514043"

--001a113ce5be60078e0550514043
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

I have built a stack from git sources. Is drm-next a good branch for basing
development on?

As you suspected, piglit reported a few crashes and failures with gpu and
cl profiles. So I will start looking at those. Thanks for the pointers!

Interest wise, I am the most interested in kernel topics, and improving
driver stability. There is a system lockup issue on my 270 when running
euro truck simulator 2 at high render resolution. I plan to get some debug
data on this once after reading up on kernel debugging.

Thanks,
Subrat

On 22-May-2017 16:01, "Christian K=C3=B6nig" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> wrot=
e:

> Hi Subrat,
>
> well finding topics for beginners on the graphics stack are usually not a=
n
> easy task because it is a rather complicated piece of software.
>
> I suggest to just start with setting up a build and test environment and
> start to run piglit (our testing suite) on a fully self compiled stack
> (kernel, libdrm, ddx, mesa).
>
> If you find any bugs while doing this (and there still are a couple I
> guess) you can start to narrow those down.
>
> Additional to that is there any particular area you are interested in?
> E.g. kernel development, video codecs or frontend stuff (OpenGL, OpenCL)?
>
> Regards,
> Christian.
>
> Am 19.05.2017 um 05:24 schrieb Subrat Meher:
>
> Hi,
>
> I am interested in working on radeon's Linux graphics stack. Are there an=
y
> areas that are more approachable to someone  unfamiliar with the stack?
>
> As for existing knowledge, I have worked with OpenGL, OpenCL and embedded
> applications.
>
> Apologies if this is not the right place for this discussion.
>
> Thanks,
> Subrat
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--001a113ce5be60078e0550514043
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div style=3D"font-family:sans-serif;font-size:13.696px" =
dir=3D"auto">Hi Christian,</div><div dir=3D"auto" style=3D"font-family:sans=
-serif;font-size:13.696px"><br></div><div dir=3D"auto" style=3D"font-family=
:sans-serif;font-size:13.696px">I have built a stack from git sources. Is d=
rm-next a good branch for basing development on?</div><div dir=3D"auto" sty=
le=3D"font-family:sans-serif;font-size:13.696px"><br></div><div dir=3D"auto=
" style=3D"font-family:sans-serif;font-size:13.696px">As you suspected, pig=
lit reported a few crashes and failures with gpu and cl profiles. So I will=
 start looking at those. Thanks for the pointers!</div><div dir=3D"auto" st=
yle=3D"font-family:sans-serif;font-size:13.696px"><br></div><div dir=3D"aut=
o" style=3D"font-family:sans-serif;font-size:13.696px">Interest wise, I am =
the most interested in kernel topics, and improving driver stability. There=
 is a system lockup issue on my 270 when running euro truck simulator 2 at =
high render resolution. I plan to get some debug data on this once after re=
ading up on kernel debugging.</div><div dir=3D"auto" style=3D"font-family:s=
ans-serif;font-size:13.696px"><br></div><div dir=3D"auto" style=3D"font-fam=
ily:sans-serif;font-size:13.696px"><div dir=3D"auto">Thanks,</div><div dir=
=3D"auto">Subrat</div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On 22-May-2017 16:01, &quot;Christian K=C3=B6nig&quot; &lt=
;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;=
 wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_-8986934828588369956moz-cite-prefix">Hi Subrat,<br>
      <br>
      well finding topics for beginners on the graphics stack are
      usually not an easy task because it is a rather complicated piece
      of software.<br>
      <br>
      I suggest to just start with setting up a build and test
      environment and start to run piglit (our testing suite) on a fully
      self compiled stack (kernel, libdrm, ddx, mesa).<br>
      <br>
      If you find any bugs while doing this (and there still are a
      couple I guess) you can start to narrow those down.<br>
      <br>
      Additional to that is there any particular area you are interested
      in? E.g. kernel development, video codecs or frontend stuff
      (OpenGL, OpenCL)?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 19.05.2017 um 05:24 schrieb Subrat Meher:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"auto">Hi,
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">I am interested in working on radeon&#39;s Linux
          graphics stack. Are there any areas that are more approachable
          to someone =C2=A0unfamiliar with the stack?</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">As for existing knowledge, I have worked with
          OpenGL, OpenCL and embedded applications.</div>
        <div dir=3D"auto"><span style=3D"font-family:sans-serif"><br>
          </span></div>
        <div dir=3D"auto"><span style=3D"font-family:sans-serif">Apologies
            if this is not the right place for this discussion.=C2=A0</span=
><br>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Thanks,</div>
        <div dir=3D"auto">Subrat</div>
      </div>
      <br>
      <fieldset class=3D"m_-8986934828588369956mimeAttachmentHeader"></fiel=
dset>
      <br>
      <pre>______________________________<wbr>_________________
amd-gfx mailing list
<a class=3D"m_-8986934828588369956moz-txt-link-abbreviated" href=3D"mailto:=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>
<a class=3D"m_-8986934828588369956moz-txt-link-freetext" href=3D"https://li=
sts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">https://lis=
ts.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </div>

</blockquote></div></div>

--001a113ce5be60078e0550514043--

--===============0312405236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0312405236==--
