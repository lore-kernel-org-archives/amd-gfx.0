From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 10:31:41 +0100
Message-ID: <e5ce02b3-a67c-d9d7-69ee-f66b5b82a2d7@amd.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <bca60368-969e-ff29-1342-432a48c23ffb@gmail.com>
 <CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0174899762=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0174899762==
Content-Type: multipart/alternative;
 boundary="------------F4DC15ECA9482B12CAC2A862"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F4DC15ECA9482B12CAC2A862
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.02.2018 um 10:23 schrieb Bas Vermeulen:
> On Wed, Feb 21, 2018 at 10:14 AM, Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 21.02.2018 um 10:06 schrieb Michel Dänzer:
>
>         On 2018-02-21 09:49 AM, Bas Vermeulen wrote:
>
>             Hi,
>
>             I am unsure if this is the right place to ask, but it
>             seems relevant.
>
>
>     Well this list is certainly the right place to ask :)
>
>
> That's what I was hoping for :)
>
>
>             I am trying to use an AMD E8860 (SI) board connected to an
>             E6500 PowerPC
>             board (T2080RDB from NXP).
>             The T2080RDB does not use a BIOS, and uses u-boot to
>             bootstrap Linux.
>
>             I have the E8860 connected to a PCIe x4 slot with an
>             adapter. The kernel
>             is a 4.1, with DRM included in the kernel and the radeon
>             as a module.
>             The radeon driver detects the card, notices the BIOS
>             hasn't posted and
>             starts things up.
>             After that, the ring tests get run, and fails on the ring
>             0 test,
>             disabling acceleration. The graphics card is (or seems to
>             be) working
>             apart from that, the driver starts up and sees the
>             connectors on the board.
>
>             When I compare dmesg on an x86 machine and the PPC
>             machine, I see that
>             the x86 machine loads a lot more firmware from the kernel
>             (probably the
>             acceleration parts?).
>
>         FWIW, that's probably just a subsequent symptom due to the
>         ring test
>         failure.
>
>
>     Could be, but IIRC we load all the firmware first then initialize
>     things and then do the ring tests when we try to start the rings.
>
>     BTW: What driver are you using? radeon or amdgpu?
>
>
> This is a south-island or sea-island chip, so using radeon.

Well SI is also supported by amdgpu, I would give that a try as well.

And BTW please try a more recent kernel as well, 4.1 is rather old.

>
>             My question is, what do I need to do to correctly
>             initialize the E8860
>             board on my powerpc machine?
>
>         Start by sharing the dmesg output, and maybe also the kernel build
>         configuration file.
>
>
>     Maybe also open a bug report to attach the dmesg, see
>     bugs.freedesktop.org <http://bugs.freedesktop.org>.
>
>
> Sure. What project does the radeon driver fall under? I couldn't find 
> the right category under Mesa, not sure what
> to file it under.

Product DRI and then select DRM/Radeon as component.

Christian.

>
> Bas Vermeulen


--------------F4DC15ECA9482B12CAC2A862
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 21.02.2018 um 10:23 schrieb Bas
      Vermeulen:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Wed, Feb 21, 2018 at 10:14 AM,
            Christian König <span dir="ltr">&lt;<a
                href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
                class="">Am 21.02.2018 um 10:06 schrieb Michel Dänzer:<br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  On 2018-02-21 09:49 AM, Bas Vermeulen wrote:<br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    Hi,<br>
                    <br>
                    I am unsure if this is the right place to ask, but
                    it seems relevant.<br>
                  </blockquote>
                </blockquote>
                <br>
              </span>
              Well this list is certainly the right place to ask :)</blockquote>
            <div><br>
            </div>
            <div>That's what I was hoping for :)</div>
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
                class="">
                <br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
                    hasn't posted and<br>
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
                  FWIW, that's probably just a subsequent symptom due to
                  the ring test<br>
                  failure.<br>
                </blockquote>
                <br>
              </span>
              Could be, but IIRC we load all the firmware first then
              initialize things and then do the ring tests when we try
              to start the rings.<br>
              <br>
              BTW: What driver are you using? radeon or amdgpu?</blockquote>
            <div><br>
            </div>
            <div>This is a south-island or sea-island chip, so using
              radeon.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Well SI is also supported by amdgpu, I would give that a try as
    well.<br>
    <br>
    And BTW please try a more recent kernel as well, 4.1 is rather old.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
                class="">
                <br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
              Maybe also open a bug report to attach the dmesg, see <a
                href="http://bugs.freedesktop.org" rel="noreferrer"
                target="_blank" moz-do-not-send="true">bugs.freedesktop.org</a>.<br>
            </blockquote>
            <div><br>
            </div>
            <div>Sure. What project does the radeon driver fall under? I
              couldn't find the right category under Mesa, not sure what</div>
            <div>to file it under.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Product DRI and then select DRM/Radeon as component.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGtoiRhHVUvg-EH9nESXjA6+T78ezQ4Cebn9rCMt09hudSqDsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div><br>
            </div>
            <div>Bas Vermeulen</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------F4DC15ECA9482B12CAC2A862--

--===============0174899762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0174899762==--
