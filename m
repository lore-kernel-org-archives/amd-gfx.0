From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: insist on 32-bit DMA for Cedar on
 PPC64/PPC64LE
Date: Fri, 23 Feb 2018 17:37:20 +0100
Message-ID: <8cae01a3-f62d-00c2-b107-10c5bb5be786@amd.com>
References: <20180221234154.6877-1-bcrocker@redhat.com>
 <20180222215713.4052-1-bcrocker@redhat.com>
 <92431e86-a247-b7d3-6a45-10d23acb2ae7@daenzer.net>
 <CALk+eRew=1nHZXRtXR430eFStOiQFUDgrp8VfsBAfcp8W9qAOA@mail.gmail.com>
 <1bcf5b27-aa25-deb6-85e9-161dd038276b@daenzer.net>
 <28f30742-6da6-4bd1-8ba0-3e5eb1677586@gmail.com>
 <CALk+eRccKjoYv29E4wphbLb4ib6r6w6ThxSZ9gf86GH2DyMQ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0053972652=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CALk+eRccKjoYv29E4wphbLb4ib6r6w6ThxSZ9gf86GH2DyMQ_Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ben Crocker <bcrocker@redhat.com>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0053972652==
Content-Type: multipart/alternative;
 boundary="------------7DBEEB4FE6F72DEFB25AE5FA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7DBEEB4FE6F72DEFB25AE5FA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben,

> I mentioned the HD 5450 purely as a matter of archeological interest.
Ok, in that case looking at the lspci -tv output doesn't tell us 
anything new.

> I suspected, but couldn't prove, that the problem might have something
> to do with the bridge (IBM POWER8 Host Bridge (PHB3)).

In that case you would see the problem with the caicos as well.

Or are there issues random enough that there could actually be some 
problem with the caicos as well and we haven't noticed it so far?

See it is really really odd that this should only happen with the cedar. 
On the other hand if it works for now, I don't see much issue having 
this workaround.

Regards,
Christian.

Am 23.02.2018 um 17:02 schrieb Ben Crocker:
> Hi Christian, Michel, Alex, et al.,
>
> I mentioned the HD 5450 purely as a matter of archeological interest.
>
> Back to the FirePro 2270 and Embedded Radeon E6465:
>
> I've attached text from both "lspci -tv" and "lspci -v."
> Actually I'm attaching a couple of different "lspci -v" outputs, one
> with the FirePro 2270 in place and one with the E6465 in (the same) place.
>
> I suspected, but couldn't prove, that the problem might have something
> to do with the bridge (IBM POWER8 Host Bridge (PHB3)).
>
> But I want to reiterate:
>
>   * Cedar GPU -> problem (before patch, that is);
>   * Caicos GPU in the same slot -> no problem
>
>
> -- Ben
>
> P.S.  Alex, thanks for applying the patch so expeditiously!
>
>
> On Fri, Feb 23, 2018 at 2:45 AM, Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Am 22.02.2018 um 18:56 schrieb Michel Dänzer:
>
>         On 2018-02-22 06:37 PM, Ben Crocker wrote:
>
>             One of my colleagues did discover a "Radeon HG 5450 PCI"
>             from February
>             2010 which did, apparently, have a Cedar GPU and very
>             definitely had a
>             (plain old) PCI connector.
>
>         There must be a PCIe-to-PCI bridge on that board. The GPU
>         itself is
>         always PCIe, and treated accordingly by the driver.
>
>
>     Ben, just an educated guess but is this one the one which is
>     failing to work correctly?
>
>     Cause the PCIe bus interface is pretty much identical over all
>     generations of the last decade or so. Only the newest Vega10
>     generation is a bit different.
>
>     So I strongly thing that this isn't related to the device being a
>     Cedar at all, but rather that you have a bridge above it which
>     doesn't correctly handle 64bit transfers.
>
>     Can you please send and "lspci -t" of both the working and the
>     problematic devices?
>
>     Thanks,
>     Christian.
>
>


--------------7DBEEB4FE6F72DEFB25AE5FA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Ben,<br>
      <br>
      <blockquote type="cite">I mentioned the HD 5450 purely as a matter
        of archeological interest.<br>
      </blockquote>
      Ok, in that case looking at the lspci -tv output doesn't tell us
      anything new.<br>
      <br>
      <blockquote type="cite">I suspected, but couldn't prove, that the
        problem might have something<br>
        to do with the bridge (IBM POWER8 Host Bridge (PHB3)).<br>
      </blockquote>
      <br>
      In that case you would see the problem with the caicos as well.<br>
      <br>
      Or are there issues random enough that there could actually be
      some problem with the caicos as well and we haven't noticed it so
      far?<br>
      <br>
      See it is really really odd that this should only happen with the
      cedar. On the other hand if it works for now, I don't see much
      issue having this workaround.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 23.02.2018 um 17:02 schrieb Ben Crocker:<br>
    </div>
    <blockquote type="cite"
cite="mid:CALk+eRccKjoYv29E4wphbLb4ib6r6w6ThxSZ9gf86GH2DyMQ_Q@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">Hi Christian, Michel, Alex, et al.,<br>
        <br>
        I mentioned the HD 5450 purely as a matter of archeological
        interest.<br>
        <br>
        Back to the FirePro 2270 and Embedded Radeon E6465:<br>
        <br>
        I've attached text from both "lspci -tv" and "lspci -v."<br>
        Actually I'm attaching a couple of different "lspci -v" outputs,
        one<br>
        with the FirePro 2270 in place and one with the E6465 in (the
        same) place.<br>
        <br>
        I suspected, but couldn't prove, that the problem might have
        something<br>
        to do with the bridge (IBM POWER8 Host Bridge (PHB3)).<br>
        <br>
        But I want to reiterate:<br>
        <ul>
          <li>Cedar GPU -&gt; problem (before patch, that is);</li>
          <li>Caicos GPU in the same slot -&gt; no problem</li>
        </ul>
        <br>
        -- Ben<br>
        <br>
        P.S.  Alex, thanks for applying the patch so expeditiously!<br>
        <br>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Fri, Feb 23, 2018 at 2:45 AM,
          Christian König <span dir="ltr">&lt;<a
              href="mailto:ckoenig.leichtzumerken@gmail.com"
              target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
              class="">Am 22.02.2018 um 18:56 schrieb Michel Dänzer:<br>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                On 2018-02-22 06:37 PM, Ben Crocker wrote:<br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  One of my colleagues did discover a "Radeon HG 5450
                  PCI" from February<br>
                  2010 which did, apparently, have a Cedar GPU and very
                  definitely had a<br>
                  (plain old) PCI connector.<br>
                </blockquote>
                There must be a PCIe-to-PCI bridge on that board. The
                GPU itself is<br>
                always PCIe, and treated accordingly by the driver.<br>
              </blockquote>
              <br>
            </span>
            Ben, just an educated guess but is this one the one which is
            failing to work correctly?<br>
            <br>
            Cause the PCIe bus interface is pretty much identical over
            all generations of the last decade or so. Only the newest
            Vega10 generation is a bit different.<br>
            <br>
            So I strongly thing that this isn't related to the device
            being a Cedar at all, but rather that you have a bridge
            above it which doesn't correctly handle 64bit transfers.<br>
            <br>
            Can you please send and "lspci -t" of both the working and
            the problematic devices?<br>
            <br>
            Thanks,<br>
            Christian.<br>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7DBEEB4FE6F72DEFB25AE5FA--

--===============0053972652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0053972652==--
