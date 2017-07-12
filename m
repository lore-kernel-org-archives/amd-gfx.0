From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Wed, 12 Jul 2017 09:39:25 +0200
Message-ID: <2a0f44cc-b893-153c-9852-b1b4855e386e@vodafone.de>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
 <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
 <0c81dd81-e84a-2381-3ce1-e08450929da8@daenzer.net>
 <c7a44542-acca-09e1-5ea5-bf9938921e54@vodafone.de>
 <CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1785914695=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1785914695==
Content-Type: multipart/alternative;
 boundary="------------A2DD0D13BBF106259F72E7D8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A2DD0D13BBF106259F72E7D8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.07.2017 um 17:43 schrieb Jason Ekstrand:
> On Tue, Jul 11, 2017 at 12:17 AM, Christian König 
> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>
>     [SNIP]
>
>                      If we ever want to share fences across processes
>                 (which we do),
>                      then this needs to be sorted in the kernel.
>
>                  That would clearly get a NAK from my side, even
>             Microsoft forbids
>                  wait before signal because you can easily end up in
>             deadlock situations.
>
>             Please don't NAK things that are required by the API
>             specification and
>             CTS tests.
>
>         There is no requirement for every aspect of the Vulkan API
>         specification
>         to be mirrored 1:1 in the kernel <-> userspace API. We have to
>         work out
>         what makes sense at each level.
>
>
>     Exactly, if we have a synchronization problem between two
>     processes that should be solved in userspace.
>
>     E.g. if process A hasn't submitted it's work to the kernel it
>     should flush it's commands before sending a flip event to the
>     compositor.
>
>
> Ok, I think there is some confusion here on what is being proposed.  
> Here are some things that are *not* being proposed:
>
>  1. This does *not* allow a client to block another client's GPU work 
> indefinitely.  This is entirely for a CPU wait API to allow for a 
> "wait for submit" as well as a "wait for finish".
Yeah, that is a rather good point.

>  2. This is *not* for system compositors that need to be robust 
> against malicious clients.
I can see the point, but I think the kernel interface should still be 
idiot prove even in the unlikely case the universe suddenly stops to 
produce idiots.

> The expected use for the OPAQUE_FD is two very tightly integrated 
> processes which trust each other but need to be able to share 
> synchronization primitives.
Well, that raises a really important question: What is the actual use 
case for this if not communication between client and compositor?

> Could we do this "in userspace"?  Yes, with added kernel API.  we 
> would need some way of strapping a second FD onto a syncobj or 
> combining two FDs into one to send across the wire or something like 
> that, then add a shared memory segment, and then pile on a bunch of 
> code to do cross-process condition variables and state tracking.  I 
> really don't see how that's a better solution than adding a flag to 
> the kernel API to just do what we want.
Way to complicated.

My thinking was rather to optionally allow a single page to be mmap()ed 
into the process address space from the fd and then put a futex, 
pthread_cond or X shared memory fence or anything like that into it.

Regards,
Christian.

--------------A2DD0D13BBF106259F72E7D8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 11.07.2017 um 17:43 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Tue, Jul 11, 2017 at 12:17 AM,
            Christian König <span dir="ltr">&lt;<a
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target="_blank"
                moz-do-not-send="true">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
                class="">[SNIP]<br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                           If we ever want to share fences across
                      processes (which we do),<br>
                           then this needs to be sorted in the kernel.<br>
                    </blockquote>
                         That would clearly get a NAK from my side, even
                    Microsoft forbids<br>
                         wait before signal because you can easily end
                    up in deadlock situations.<br>
                    <br>
                    Please don't NAK things that are required by the API
                    specification and<br>
                    CTS tests.<br>
                  </blockquote>
                  There is no requirement for every aspect of the Vulkan
                  API specification<br>
                  to be mirrored 1:1 in the kernel &lt;-&gt; userspace
                  API. We have to work out<br>
                  what makes sense at each level.<br>
                </blockquote>
                <br>
              </span>
              Exactly, if we have a synchronization problem between two
              processes that should be solved in userspace.<br>
              <br>
              E.g. if process A hasn't submitted it's work to the kernel
              it should flush it's commands before sending a flip event
              to the compositor.<br>
            </blockquote>
          </div>
          <br>
        </div>
        <div class="gmail_extra">Ok, I think there is some confusion
          here on what is being proposed.  Here are some things that are
          *not* being proposed:<br>
          <br>
        </div>
        <div class="gmail_extra"> 1. This does *not* allow a client to
          block another client's GPU work indefinitely.  This is
          entirely for a CPU wait API to allow for a "wait for submit"
          as well as a "wait for finish".<br>
        </div>
      </div>
    </blockquote>
    Yeah, that is a rather good point.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra"> 2. This is *not* for system
          compositors that need to be robust against malicious clients.<br>
        </div>
      </div>
    </blockquote>
    I can see the point, but I think the kernel interface should still
    be idiot prove even in the unlikely case the universe suddenly stops
    to produce idiots.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">The expected use for the OPAQUE_FD is
          two very tightly integrated processes which trust each other
          but need to be able to share synchronization primitives.<br>
        </div>
      </div>
    </blockquote>
    Well, that raises a really important question: What is the actual
    use case for this if not communication between client and
    compositor?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">Could we do this "in userspace"?  Yes,
          with added kernel API.  we would need some way of strapping a
          second FD onto a syncobj or combining two FDs into one to send
          across the wire or something like that, then add a shared
          memory segment, and then pile on a bunch of code to do
          cross-process condition variables and state tracking.  I
          really don't see how that's a better solution than adding a
          flag to the kernel API to just do what we want.<br>
        </div>
      </div>
    </blockquote>
    Way to complicated.<br>
    <br>
    My thinking was rather to optionally allow a single page to be
    mmap()ed into the process address space from the fd and then put a
    futex, pthread_cond or X shared memory fence or anything like that
    into it.<br>
    <br>
    Regards,<br>
    Christian.<br>
  </body>
</html>

--------------A2DD0D13BBF106259F72E7D8--

--===============1785914695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1785914695==--
