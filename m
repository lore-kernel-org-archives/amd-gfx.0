From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Topics for beginners
Date: Mon, 22 May 2017 10:00:28 +0200
Message-ID: <d549afe3-63af-a3d9-ce14-426ffad9e979@vodafone.de>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0027439280=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAMw8iYqswbvJs9bGobef81CR0rqx0jxLM=JFpMyFC9TNpFDhZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Subrat Meher <smeher02.aoe3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0027439280==
Content-Type: multipart/alternative;
 boundary="------------1FFCC09F0AEC658C3E084FB7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1FFCC09F0AEC658C3E084FB7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrat,

well finding topics for beginners on the graphics stack are usually not 
an easy task because it is a rather complicated piece of software.

I suggest to just start with setting up a build and test environment and 
start to run piglit (our testing suite) on a fully self compiled stack 
(kernel, libdrm, ddx, mesa).

If you find any bugs while doing this (and there still are a couple I 
guess) you can start to narrow those down.

Additional to that is there any particular area you are interested in? 
E.g. kernel development, video codecs or frontend stuff (OpenGL, OpenCL)?

Regards,
Christian.

Am 19.05.2017 um 05:24 schrieb Subrat Meher:
> Hi,
>
> I am interested in working on radeon's Linux graphics stack. Are there 
> any areas that are more approachable to someone  unfamiliar with the 
> stack?
>
> As for existing knowledge, I have worked with OpenGL, OpenCL and 
> embedded applications.
>
> Apologies if this is not the right place for this discussion.
>
> Thanks,
> Subrat
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------1FFCC09F0AEC658C3E084FB7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Subrat,<br>
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
    <blockquote type="cite"
cite="mid:CAMw8iYqswbvJs9bGobef81CR0rqx0jxLM=JFpMyFC9TNpFDhZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="auto">Hi,
        <div dir="auto"><br>
        </div>
        <div dir="auto">I am interested in working on radeon's Linux
          graphics stack. Are there any areas that are more approachable
          to someone  unfamiliar with the stack?</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">As for existing knowledge, I have worked with
          OpenGL, OpenCL and embedded applications.</div>
        <div dir="auto"><span style="font-family:sans-serif"><br>
          </span></div>
        <div dir="auto"><span style="font-family:sans-serif">Apologies
            if this is not the right place for this discussion. </span><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Thanks,</div>
        <div dir="auto">Subrat</div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------1FFCC09F0AEC658C3E084FB7--

--===============0027439280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0027439280==--
