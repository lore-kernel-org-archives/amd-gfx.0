From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Wed, 9 Jan 2019 19:41:11 +0100
Message-ID: <7f85afd6-b17b-1c50-ba03-c03dd6e9a362@gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
 <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
 <513ee137-7e99-c8fc-9e3b-e9077ead60a3@gmail.com>
 <CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0218347674=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0218347674==
Content-Type: multipart/alternative;
 boundary="------------270B7C3EEF0DEBAB647D19FF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------270B7C3EEF0DEBAB647D19FF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.19 um 17:14 schrieb Marek Olšák:
> On Wed, Jan 9, 2019 at 8:09 AM Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 09.01.19 um 13:36 schrieb Marek Olšák:
>>
>>
>>     On Wed, Jan 9, 2019, 5:28 AM Christian König
>>     <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>     <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>         Looks good, but I'm wondering what's the actual improvement?
>>
>>
>>     No malloc calls and 1 less for loop copying the bo list.
>
>     Yeah, but didn't we want to get completely rid of the bo list?
>
>
> If we have multiple IBs (e.g. gfx + compute) that share a BO list, I 
> think it's faster to send the BO list to the kernel only once.

That's not really faster.

The only thing we safe us is a single loop over all BOs to lockup the 
handle into a pointer and that is only a tiny fraction of the overhead.

The majority of the overhead is locking the BOs and reserving space for 
the submission.

What could really help here is to submit gfx+comput together in just one 
CS IOCTL. This way we would need the locking and space reservation only 
once.

It's a bit of work in the kernel side, but certainly doable.

Christian.

>
> Marek
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------270B7C3EEF0DEBAB647D19FF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 09.01.19 um 17:14 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_quote">
            <div dir="ltr">On Wed, Jan 9, 2019 at 8:09 AM Christian
              König &lt;<a
                href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF">
                <div
class="m_8930908994027207900m_-7323258551939539738gmail-m_4443106390953893387gmail-m_-3252015337124169842moz-cite-prefix">Am
                  09.01.19 um 13:36 schrieb Marek Olšák:<br>
                </div>
                <blockquote type="cite">
                  <div dir="auto">
                    <div><br>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr">On Wed, Jan 9, 2019, 5:28 AM
                          Christian König &lt;<a
                            href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">Looks good,
                          but I'm wondering what's the actual
                          improvement?<br>
                        </blockquote>
                      </div>
                    </div>
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">No malloc calls and 1 less for loop
                      copying the bo list.</div>
                  </div>
                </blockquote>
                <br>
                Yeah, but didn't we want to get completely rid of the bo
                list?<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            If we have multiple IBs (e.g. gfx + compute) that share a BO
            list, I think it's faster to send the BO list to the kernel
            only once.</div>
        </div>
      </div>
    </blockquote>
    <br>
    That's not really faster.<br>
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
    It's a bit of work in the kernel side, but certainly doable.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_quote"><br>
          </div>
          <div class="gmail_quote">Marek<br>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------270B7C3EEF0DEBAB647D19FF--

--===============0218347674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0218347674==--
