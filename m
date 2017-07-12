From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Wed, 12 Jul 2017 18:45:38 +0200
Message-ID: <f1375dda-2997-7ed5-dcde-e2fc5e1c44c2@vodafone.de>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
 <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
 <0c81dd81-e84a-2381-3ce1-e08450929da8@daenzer.net>
 <c7a44542-acca-09e1-5ea5-bf9938921e54@vodafone.de>
 <CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw@mail.gmail.com>
 <2a0f44cc-b893-153c-9852-b1b4855e386e@vodafone.de>
 <CAPM=9twkH4H0Buxpb7nKAMawNxouWCombhfAh++pNpSZNMLRow@mail.gmail.com>
 <CAOFGe95mj1G_Ap0oOPFyatZWEbEk_Kwo8Wn_E+eYS16Nhz_huQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1622437765=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAOFGe95mj1G_Ap0oOPFyatZWEbEk_Kwo8Wn_E+eYS16Nhz_huQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1622437765==
Content-Type: multipart/alternative;
 boundary="------------969E556DC2AD0A062C5BDC99"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------969E556DC2AD0A062C5BDC99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 12.07.2017 um 17:53 schrieb Jason Ekstrand:
> [SNIP]
>
>     Is that easier than just waiting in the kernel, I'm not sure how
>     optimised we need this path to be.
>
>
> I don't think so.  I think it's more-or-less the same code regardless 
> of how it's done.  The advantage of doing it in the kernel is that 
> it's standardized (we don't have to both go write that userspace code) 
> and it doesn't have the problems stated above.

Ok, I'm convinced. The next price question is then how do we do it?

I mean writing an IOCTL to wait for a fence to appear is simple, but do 
we also need to wait for a fence to change?

As long as waits don't consume fences that might be rather tricky.

Christian.

--------------969E556DC2AD0A062C5BDC99
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 12.07.2017 um 17:53 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOFGe95mj1G_Ap0oOPFyatZWEbEk_Kwo8Wn_E+eYS16Nhz_huQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">[SNIP]<br>
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
                class="">
              </span>Is that easier than just waiting in the kernel, I'm
              not sure how<br>
              optimised we need this path to be.<span class="HOEnZb"><font
                  color="#888888"><br>
                </font></span></blockquote>
          </div>
          <br>
        </div>
        <div class="gmail_extra">I don't think so.  I think it's
          more-or-less the same code regardless of how it's done.  The
          advantage of doing it in the kernel is that it's standardized
          (we don't have to both go write that userspace code) and it
          doesn't have the problems stated above.<br>
        </div>
      </div>
    </blockquote>
    <br>
    Ok, I'm convinced. The next price question is then how do we do it?<br>
    <br>
    I mean writing an IOCTL to wait for a fence to appear is simple, but
    do we also need to wait for a fence to change?<br>
    <br>
    As long as waits don't consume fences that might be rather tricky.<br>
    <br>
    Christian.<br>
  </body>
</html>

--------------969E556DC2AD0A062C5BDC99--

--===============1622437765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1622437765==--
