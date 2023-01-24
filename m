Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF3AC25B4E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 08:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3E310E62D;
	Tue, 24 Jan 2023 08:29:09 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD9110E62D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 08:29:08 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id h16so13057058wrz.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 00:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWEBYDE90pt5jMdQnFNnS8AFNzPAC26mZbQUQnKSHGg=;
 b=aFGJIRlz5b1LCR6wIlXzWmessktP7bswhcZ0xWmnI2WQ8GOqePWsjKX+nkIxap5ZkH
 mrMIWFVvs1bLNrmUyg0wsOK/Uu4tyiHydtieeVnPEYuJnCe6cK5ASdwIomw1khzI9Y2t
 tX/+ddM++1eb3c3Be4jtOy7Vqub4wI+HDHAEPcKN1Hj9RAG766yUzbxEhOOIIB/Lxlpw
 J1LZKc0L4fF0DL986R6mdQLCGCVLe0iePjIPd6T+3S8ArOYBky0FGGdyHERhcYhYkRAU
 6XqZyB699FyHobsvLcI4MPRQNk0+tEn1bsVjfnOE20jWkSP3IOPfpVxqLYNJ0NiJvNjO
 1dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sWEBYDE90pt5jMdQnFNnS8AFNzPAC26mZbQUQnKSHGg=;
 b=b8Uj3DLur92ungh3fYk7948uBmWQY3H6dj/THZCbuiPTULnb5LyR09IjJlVyzjM5oG
 iUk7EBafe2bb8J+ZJYdM/fi9mFSwYSTJOVJLPtLp+TSCaU1OvzqxvNI9Zq1wOcEws/eh
 UwOPKxitLh8NC4q3odzwVQR5+SLnZQG/OzbCwg2TMGgfRJDjRQNjjs1NRizwy8+jpyYj
 cChTypyL9qCfovFapMMECjatzJI+GtFRX6a+dRz5QtXUgUz4ish3KbuAqFdsjlx1c6F/
 dQ5YX/raHrSt7s4gPQpHWuGfotUCbBl/1uH533dTHzkLpb6CVIO4j0KfrFaLC+l/QFRP
 jSig==
X-Gm-Message-State: AFqh2koWoOrgic98xh05kKui9dUr4BJ5eR4BvYWWo5ehEMU3flZ35vHr
 t6TdIDcWNlK1xgKOHvLEk7AprbUG9dM=
X-Google-Smtp-Source: AMrXdXsjHvni/kiU8lxOuIPXFX2+2c53moP1/pY+1Es1h8VmIyG/HRJKKUCED4nCmu7DsfbUHVekgg==
X-Received: by 2002:adf:fd83:0:b0:2bd:dbd8:d41e with SMTP id
 d3-20020adffd83000000b002bddbd8d41emr23840388wrr.57.1674548946659; 
 Tue, 24 Jan 2023 00:29:06 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 j19-20020adfd213000000b002423620d356sm1282769wrh.35.2023.01.24.00.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jan 2023 00:29:06 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------TRlaO7dvMo4gt4UcxnXTrmBY"
Message-ID: <b03e1daf-e035-6199-5f11-8b9f9bf0d9f8@gmail.com>
Date: Tue, 24 Jan 2023 09:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
 <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
 <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
 <CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com>
 <d1463910-1eab-2dac-a633-812ada011cc4@gmail.com>
 <CAAxE2A5fWDp==muWuXSXuGGHtT_RThLpC1rK92c2mLVLdmGdUQ@mail.gmail.com>
 <fe0ca4a4-b339-20ab-fd42-68b2a5e00e9c@gmail.com>
 <CAAxE2A71r9sQqFCPajK2VhL5GBJZ=Js5YRvYkrrsRtTRT5yxTg@mail.gmail.com>
 <CAAxE2A6JcREmKKmh1n0xSgkOZq77kpnzC-27-srunLKduyAwiw@mail.gmail.com>
 <4992933e-ad45-5f7a-b7af-39c6d0948321@gmail.com>
 <CAAxE2A4rxdVqYp5qvN4DyV-=9TxE6EgeXPu++=7f1BEEhOs+Bw@mail.gmail.com>
 <a11b75da-9008-411d-66ed-6dc3c21f73ea@gmail.com>
 <CAAxE2A686+RMwmUkN=dLRptKaHKEQemXDfMoidQbw55JrVWQWA@mail.gmail.com>
 <CAAxE2A4zRPr5fJdQdAoBw8=OMrm9BjJHgnzLrXoomq0o-29UBw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A4zRPr5fJdQdAoBw8=OMrm9BjJHgnzLrXoomq0o-29UBw@mail.gmail.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------TRlaO7dvMo4gt4UcxnXTrmBY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.01.23 um 09:27 schrieb Marek Olšák:
> A new Gallium HUD "value producer" could be added that reads fdinfo 
> without calling the driver.

That sounds good. To be honest I would have plenty of use for that.

> I still think there is merit in having this in amdgpu_drm.h too.

Why?

Christian.

>
> Marek
>
> On Tue, Jan 24, 2023 at 3:13 AM Marek Olšák <maraeo@gmail.com> wrote:
>
>     The table of exposed driver-specific counters:
>     https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/radeonsi/si_query.c#L1751
>
>     Counter enums. They use the same interface as e.g. occlusion
>     queries, except that begin_query and end_query save the results in
>     the driver/CPU.
>     https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/radeonsi/si_query.h#L45
>
>     Counters exposed by the winsys:
>     https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/include/winsys/radeon_winsys.h#L126
>
>     I just need to query the counters in the winsys and return them.
>
>     Marek
>
>     On Tue, Jan 24, 2023 at 2:58 AM Christian König
>     <ckoenig.leichtzumerken@gmail.com> wrote:
>
>         How are the counters which the HUD consumes declared?
>
>         See what I want to avoid is a) to nail down the interface with
>         the kernel on specific values and b) make it possible to
>         easily expose new values.
>
>         In other words what we could do with fdinfo is to have
>         something like this:
>
>         GALLIUM_FDINFO_HUD=drm-memory-vram,amd-evicted-vram,amd-mclk
>         glxgears
>
>         And the HUD just displays the values the kernel provides
>         without the need to re-compile mesa when we want to add some
>         more values nor have the values as part of the UAPI.
>
>         Christian.
>
>         Am 24.01.23 um 08:37 schrieb Marek Olšák:
>>         The Gallium HUD doesn't consume strings. It only consumes
>>         values that are exposed as counters from the driver. In this
>>         case, we need the driver to expose evicted stats as counters.
>>         Each counter can set whether the value is absolute (e.g.
>>         memory usage) or monotonic (e.g. perf counter). Parsing
>>         fdinfo to get the values is undesirable.
>>
>>         Marek
>>
>>         On Mon, Jan 23, 2023 at 4:31 AM Christian König
>>         <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>             Let's do this as valid in fdinfo.
>>
>>             This way we can easily extend whatever the kernel wants
>>             to display as statistics in the userspace HUD.
>>
>>             Regards,
>>             Christian.
>>
>>             Am 21.01.23 um 01:45 schrieb Marek Olšák:
>>>             We badly need a way to query evicted memory usage. It's
>>>             essential for investigating performance problems and it
>>>             uncovered the buddy allocator disaster. Please either
>>>             suggest an alternative, suggest changes, or review. We
>>>             need it ASAP.
>>>
>>>             Thanks,
>>>             Marek
>>>
>>>             On Tue, Jan 10, 2023 at 11:55 AM Marek Olšák
>>>             <maraeo@gmail.com> wrote:
>>>
>>>                 On Tue, Jan 10, 2023 at 11:23 AM Christian König
>>>                 <ckoenig.leichtzumerken@gmail.com> wrote:
>>>
>>>                     Am 10.01.23 um 16:28 schrieb Marek Olšák:
>>>>                     On Wed, Jan 4, 2023 at 9:51 AM Christian König
>>>>                     <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>
>>>>                         Am 04.01.23 um 00:08 schrieb Marek Olšák:
>>>>>                         I see about the access now, but did you
>>>>>                         even look at the patch?
>>>>
>>>>                         I did look at the patch, but I haven't
>>>>                         fully understood yet what you are trying to
>>>>                         do here.
>>>>
>>>>
>>>>                     First and foremost, it returns the evicted size
>>>>                     of VRAM and visible VRAM, and returns visible
>>>>                     VRAM usage. It should be obvious which stat
>>>>                     includes the size of another.
>>>>
>>>>
>>>>>                         Because what the patch does isn't even
>>>>>                         exposed to common drm code, such as the
>>>>>                         preferred domain and visible VRAM
>>>>>                         placement, so it can't be in fdinfo right now.
>>>>>
>>>>>                         Or do you even know what fdinfo contains?
>>>>>                         Because it contains nothing useful. It
>>>>>                         only has VRAM and GTT usage, which we
>>>>>                         already have in the INFO ioctl, so it has
>>>>>                         nothing that we need. We mainly need the
>>>>>                         eviction information and visible VRAM
>>>>>                         information now. Everything else is a bonus.
>>>>
>>>>                         Well the main question is what are you
>>>>                         trying to get from that information? The
>>>>                         eviction list for example is completely
>>>>                         meaningless to userspace, that stuff is
>>>>                         only temporary and will be cleared on the
>>>>                         next CS again.
>>>>
>>>>
>>>>                     I don't know what you mean. The returned
>>>>                     eviction stats look correct and are stable
>>>>                     (they don't change much). You can suggest
>>>>                     changes if you think some numbers are not
>>>>                     reported correctly.
>>>>
>>>>
>>>>                         What we could expose is the VRAM
>>>>                         over-commit value, e.g. how much BOs which
>>>>                         where supposed to be in VRAM are in GTT
>>>>                         now. I think that's what you are looking
>>>>                         for here, right?
>>>>
>>>>
>>>>                     The VRAM overcommit value is "evicted_vram".
>>>>
>>>>
>>>>>                         Also, it's undesirable to open and parse a
>>>>>                         text file if we can just call an ioctl.
>>>>
>>>>                         Well I see the reasoning for that, but I
>>>>                         also see why other drivers do a lot of the
>>>>                         stuff we have as IOCTL as separate files in
>>>>                         sysfs, fdinfo or debugfs.
>>>>
>>>>                         Especially repeating all the static
>>>>                         information which were already available
>>>>                         under sysfs in the INFO IOCTL was a design
>>>>                         mistake as far as I can see. Just compare
>>>>                         what AMDGPU and the KFD code is doing to
>>>>                         what for example i915 is doing.
>>>>
>>>>                         Same for things like debug information
>>>>                         about a process. The fdinfo stuff can be
>>>>                         queried from external tools (gdb, gputop,
>>>>                         umr etc...) as well which makes that
>>>>                         interface more preferred.
>>>>
>>>>
>>>>                     Nothing uses fdinfo in Mesa. No driver uses
>>>>                     sysfs in Mesa except drm shims, noop drivers,
>>>>                     and Intel for perf metrics. sysfs itself is an
>>>>                     unusable mess for the PCIe query and is missing
>>>>                     information.
>>>>
>>>>                     I'm not against exposing more stuff through
>>>>                     sysfs and fdinfo for tools, but I don't see any
>>>>                     reason why drivers should use it (other than
>>>>                     for slowing down queries and initialization).
>>>
>>>                     That's what I'm asking: Is this for some tool or
>>>                     to make some driver decision based on it?
>>>
>>>                     If you just want the numbers for over displaying
>>>                     then I think it would be better to put this into
>>>                     fdinfo together with the other existing stuff there.
>>>
>>>
>>>                     If you want to make allocation decisions based
>>>                     on this then we should have that as IOCTL or
>>>                     even better as mmap() page between kernel and
>>>                     userspace. But in this case I would also
>>>                     calculation the numbers completely different as
>>>                     well.
>>>
>>>                     See we have at least the following things in the
>>>                     kernel:
>>>                     1. The eviction list in the VM.
>>>                         Those are the BOs which are currently
>>>                     evicted and tried to moved back in on the next CS.
>>>
>>>                     2. The VRAM over commit value.
>>>                         In other words how much more VRAM than
>>>                     available has the application tried to allocate?
>>>
>>>                     3. The visible VRAM usage by this application.
>>>
>>>                     The end goal is that the eviction list will go
>>>                     away, e.g. we will always have stable
>>>                     allocations based on allocations of other
>>>                     applications and not constantly swap things in
>>>                     and out.
>>>
>>>                     When you now expose the eviction list to
>>>                     userspace we will be stuck with this interface
>>>                     forever.
>>>
>>>
>>>                 It's for the GALLIUM HUD.
>>>
>>>                 The only missing thing is the size of all evicted
>>>                 VRAM allocations, and the size of all evicted
>>>                 visible VRAM allocations.
>>>
>>>                 1. No list is exposed. Only sums of buffer sizes are
>>>                 exposed. Also, the eviction list has no meaning
>>>                 here. All lists are treated equally, and mem_type is
>>>                 compared with preferred_domains to determine where
>>>                 buffers are and where they should be.
>>>
>>>                 2. I'm not interested in the overcommit value. I'm
>>>                 only interested in knowing the number of bytes of
>>>                 evicted VRAM right now. It can be as variable as the
>>>                 CPU load, but in practice it shouldn't be because
>>>                 PCIe doesn't have the bandwidth to move things quickly.
>>>
>>>                 3. Yes, that's true.
>>>
>>>                 Marek
>>>
>>
>

--------------TRlaO7dvMo4gt4UcxnXTrmBY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 24.01.23 um 09:27 schrieb Marek Olšák:<br>
    <blockquote type="cite"
cite="mid:CAAxE2A4zRPr5fJdQdAoBw8=OMrm9BjJHgnzLrXoomq0o-29UBw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>A new Gallium HUD "value producer" could be added that
          reads fdinfo without calling the driver.</div>
      </div>
    </blockquote>
    <br>
    That sounds good. To be honest I would have plenty of use for that.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A4zRPr5fJdQdAoBw8=OMrm9BjJHgnzLrXoomq0o-29UBw@mail.gmail.com">
      <div dir="ltr">
        <div>I still think there is merit in having this in amdgpu_drm.h
          too.</div>
      </div>
    </blockquote>
    <br>
    Why?<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A4zRPr5fJdQdAoBw8=OMrm9BjJHgnzLrXoomq0o-29UBw@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Jan 24, 2023 at 3:13
          AM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div>The table of exposed driver-specific counters:<br>
            </div>
            <div><a
href="https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/radeonsi/si_query.c#L1751"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/radeonsi/si_query.c#L1751</a></div>
            <div><br>
            </div>
            <div>Counter enums. They use the same interface as e.g.
              occlusion queries, except that begin_query and end_query
              save the results in the driver/CPU.<br>
            </div>
            <div><a
href="https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/radeonsi/si_query.h#L45"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/radeonsi/si_query.h#L45</a></div>
            <div><br>
            </div>
            <div>Counters exposed by the winsys:</div>
            <div><a
href="https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/include/winsys/radeon_winsys.h#L126"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/include/winsys/radeon_winsys.h#L126</a></div>
            <div><br>
            </div>
            <div>I just need to query the counters in the winsys and
              return them.<br>
            </div>
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Tue, Jan 24, 2023 at
              2:58 AM Christian König &lt;<a
                href="mailto:ckoenig.leichtzumerken@gmail.com"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div> How are the counters which the HUD consumes
                declared?<br>
                <br>
                See what I want to avoid is a) to nail down the
                interface with the kernel on specific values and b) make
                it possible to easily expose new values.<br>
                <br>
                In other words what we could do with fdinfo is to have
                something like this:<br>
                <br>
GALLIUM_FDINFO_HUD=drm-memory-vram,amd-evicted-vram,amd-mclk glxgears<br>
                <br>
                And the HUD just displays the values the kernel provides
                without the need to re-compile mesa when we want to add
                some more values nor have the values as part of the
                UAPI.<br>
                <br>
                Christian.<br>
                <br>
                <div>Am 24.01.23 um 08:37 schrieb Marek Olšák:<br>
                </div>
                <blockquote type="cite">
                  <div dir="ltr">
                    <div>The Gallium HUD doesn't consume strings. It
                      only consumes values that are exposed as counters
                      from the driver. In this case, we need the driver
                      to expose evicted stats as counters. Each counter
                      can set whether the value is absolute (e.g. memory
                      usage) or monotonic (e.g. perf counter). Parsing
                      fdinfo to get the values is undesirable.<br>
                    </div>
                    <div><br>
                    </div>
                    <div>Marek<br>
                    </div>
                  </div>
                  <br>
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Mon, Jan 23,
                      2023 at 4:31 AM Christian König &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        target="_blank" moz-do-not-send="true"
                        class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class="gmail_quote" style="margin:0px
                      0px 0px 0.8ex;border-left:1px solid
                      rgb(204,204,204);padding-left:1ex">
                      <div> Let's do this as valid in fdinfo.<br>
                        <br>
                        This way we can easily extend whatever the
                        kernel wants to display as statistics in the
                        userspace HUD.<br>
                        <br>
                        Regards,<br>
                        Christian.<br>
                        <br>
                        <div>Am 21.01.23 um 01:45 schrieb Marek Olšák:<br>
                        </div>
                        <blockquote type="cite">
                          <div dir="ltr">
                            <div>We badly need a way to query evicted
                              memory usage. It's essential for
                              investigating performance problems and it
                              uncovered the buddy allocator disaster.
                              Please either suggest an alternative,
                              suggest changes, or review. We need it
                              ASAP.<br>
                            </div>
                            <div><br>
                            </div>
                            <div>Thanks,</div>
                            <div>Marek<br>
                            </div>
                          </div>
                          <br>
                          <div class="gmail_quote">
                            <div dir="ltr" class="gmail_attr">On Tue,
                              Jan 10, 2023 at 11:55 AM Marek Olšák &lt;<a
                                href="mailto:maraeo@gmail.com"
                                target="_blank" moz-do-not-send="true"
                                class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
                              wrote:<br>
                            </div>
                            <blockquote class="gmail_quote"
                              style="margin:0px 0px 0px
                              0.8ex;border-left:1px solid
                              rgb(204,204,204);padding-left:1ex">
                              <div dir="ltr">
                                <div class="gmail_quote">
                                  <div dir="ltr" class="gmail_attr">On
                                    Tue, Jan 10, 2023 at 11:23 AM
                                    Christian König &lt;<a
                                      href="mailto:ckoenig.leichtzumerken@gmail.com"
                                      target="_blank"
                                      moz-do-not-send="true"
                                      class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                                    wrote:<br>
                                  </div>
                                  <blockquote class="gmail_quote"
                                    style="margin:0px 0px 0px
                                    0.8ex;border-left:1px solid
                                    rgb(204,204,204);padding-left:1ex">
                                    <div> Am 10.01.23 um 16:28 schrieb
                                      Marek Olšák:<br>
                                      <blockquote type="cite">
                                        <div dir="ltr">
                                          <div class="gmail_quote">
                                            <div dir="ltr"
                                              class="gmail_attr">On Wed,
                                              Jan 4, 2023 at 9:51 AM
                                              Christian König &lt;<a
                                                href="mailto:ckoenig.leichtzumerken@gmail.com"
                                                target="_blank"
                                                moz-do-not-send="true"
                                                class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                                              wrote:<br>
                                            </div>
                                            <blockquote
                                              class="gmail_quote"
                                              style="margin:0px 0px 0px
                                              0.8ex;border-left:1px
                                              solid
                                              rgb(204,204,204);padding-left:1ex">
                                              <div> Am 04.01.23 um 00:08
                                                schrieb Marek Olšák:<br>
                                                <blockquote type="cite">
                                                  <div dir="ltr">
                                                    <div>I see about the
                                                      access now, but
                                                      did you even look
                                                      at the patch?</div>
                                                  </div>
                                                </blockquote>
                                                <br>
                                                I did look at the patch,
                                                but I haven't fully
                                                understood yet what you
                                                are trying to do here.<br>
                                              </div>
                                            </blockquote>
                                            <div><br>
                                            </div>
                                            <div>First and foremost, it
                                              returns the evicted size
                                              of VRAM and visible VRAM,
                                              and returns visible VRAM
                                              usage. It should be
                                              obvious which stat
                                              includes the size of
                                              another.<br>
                                            </div>
                                            <div><br>
                                            </div>
                                            <blockquote
                                              class="gmail_quote"
                                              style="margin:0px 0px 0px
                                              0.8ex;border-left:1px
                                              solid
                                              rgb(204,204,204);padding-left:1ex">
                                              <div> <br>
                                                <blockquote type="cite">
                                                  <div dir="ltr">
                                                    <div> Because what
                                                      the patch does
                                                      isn't even exposed
                                                      to common drm
                                                      code, such as the
                                                      preferred domain
                                                      and visible VRAM
                                                      placement, so it
                                                      can't be in fdinfo
                                                      right now.<br>
                                                    </div>
                                                    <div><br>
                                                    </div>
                                                    <div>Or do you even
                                                      know what fdinfo
                                                      contains? Because
                                                      it contains
                                                      nothing useful. It
                                                      only has VRAM and
                                                      GTT usage, which
                                                      we already have in
                                                      the INFO ioctl, so
                                                      it has nothing
                                                      that we need. We
                                                      mainly need the
                                                      eviction
                                                      information and
                                                      visible VRAM
                                                      information now.
                                                      Everything else is
                                                      a bonus.<br>
                                                    </div>
                                                  </div>
                                                </blockquote>
                                                <br>
                                                Well the main question
                                                is what are you trying
                                                to get from that
                                                information? The
                                                eviction list for
                                                example is completely
                                                meaningless to
                                                userspace, that stuff is
                                                only temporary and will
                                                be cleared on the next
                                                CS again.<br>
                                              </div>
                                            </blockquote>
                                            <div><br>
                                            </div>
                                            <div>I don't know what you
                                              mean. The returned
                                              eviction stats look
                                              correct and are stable
                                              (they don't change much).
                                              You can suggest changes if
                                              you think some numbers are
                                              not reported correctly.<br>
                                            </div>
                                            <div> </div>
                                            <blockquote
                                              class="gmail_quote"
                                              style="margin:0px 0px 0px
                                              0.8ex;border-left:1px
                                              solid
                                              rgb(204,204,204);padding-left:1ex">
                                              <div> <br>
                                                What we could expose is
                                                the VRAM over-commit
                                                value, e.g. how much BOs
                                                which where supposed to
                                                be in VRAM are in GTT
                                                now. I think that's what
                                                you are looking for
                                                here, right?<br>
                                              </div>
                                            </blockquote>
                                            <div><br>
                                            </div>
                                            <div>The VRAM overcommit
                                              value is "evicted_vram".<br>
                                            </div>
                                            <div> </div>
                                            <blockquote
                                              class="gmail_quote"
                                              style="margin:0px 0px 0px
                                              0.8ex;border-left:1px
                                              solid
                                              rgb(204,204,204);padding-left:1ex">
                                              <div> <br>
                                                <blockquote type="cite">
                                                  <div dir="ltr">
                                                    <div>
                                                      <div>Also, it's
                                                        undesirable to
                                                        open and parse a
                                                        text file if we
                                                        can just call an
                                                        ioctl.</div>
                                                    </div>
                                                  </div>
                                                </blockquote>
                                                <br>
                                                Well I see the reasoning
                                                for that, but I also see
                                                why other drivers do a
                                                lot of the stuff we have
                                                as IOCTL as separate
                                                files in sysfs, fdinfo
                                                or debugfs.<br>
                                                <br>
                                                Especially repeating all
                                                the static information
                                                which were already
                                                available under sysfs in
                                                the INFO IOCTL was a
                                                design mistake as far as
                                                I can see. Just compare
                                                what AMDGPU and the KFD
                                                code is doing to what
                                                for example i915 is
                                                doing.<br>
                                                <br>
                                                Same for things like
                                                debug information about
                                                a process. The fdinfo
                                                stuff can be queried
                                                from external tools
                                                (gdb, gputop, umr
                                                etc...) as well which
                                                makes that interface
                                                more preferred.<br>
                                              </div>
                                            </blockquote>
                                            <div><br>
                                            </div>
                                            <div>Nothing uses fdinfo in
                                              Mesa. No driver uses sysfs
                                              in Mesa except drm shims,
                                              noop drivers, and Intel
                                              for perf metrics. sysfs
                                              itself is an unusable mess
                                              for the PCIe query and is
                                              missing information.</div>
                                            <div><br>
                                            </div>
                                            <div>I'm not against
                                              exposing more stuff
                                              through sysfs and fdinfo
                                              for tools, but I don't see
                                              any reason why drivers
                                              should use it (other than
                                              for slowing down queries
                                              and initialization).</div>
                                          </div>
                                        </div>
                                      </blockquote>
                                      <br>
                                      That's what I'm asking: Is this
                                      for some tool or to make some
                                      driver decision based on it?<br>
                                      <br>
                                      If you just want the numbers for
                                      over displaying then I think it
                                      would be better to put this into
                                      fdinfo together with the other
                                      existing stuff there.<br>
                                    </div>
                                  </blockquote>
                                  <blockquote class="gmail_quote"
                                    style="margin:0px 0px 0px
                                    0.8ex;border-left:1px solid
                                    rgb(204,204,204);padding-left:1ex">
                                    <div> <br>
                                      If you want to make allocation
                                      decisions based on this then we
                                      should have that as IOCTL or even
                                      better as mmap() page between
                                      kernel and userspace. But in this
                                      case I would also calculation the
                                      numbers completely different as
                                      well.<br>
                                      <br>
                                      See we have at least the following
                                      things in the kernel:<br>
                                      1. The eviction list in the VM.<br>
                                          Those are the BOs which are
                                      currently evicted and tried to
                                      moved back in on the next CS.<br>
                                      <br>
                                      2. The VRAM over commit value.<br>
                                          In other words how much more
                                      VRAM than available has the
                                      application tried to allocate?<br>
                                      <br>
                                      3. The visible VRAM usage by this
                                      application.<br>
                                      <br>
                                      The end goal is that the eviction
                                      list will go away, e.g. we will
                                      always have stable allocations
                                      based on allocations of other
                                      applications and not constantly
                                      swap things in and out.<br>
                                      <br>
                                      When you now expose the eviction
                                      list to userspace we will be stuck
                                      with this interface forever.<br>
                                    </div>
                                  </blockquote>
                                  <div><br>
                                  </div>
                                  <div>It's for the GALLIUM HUD.</div>
                                  <div><br>
                                  </div>
                                  <div>The only missing thing is the
                                    size of all evicted VRAM
                                    allocations, and the size of all
                                    evicted visible VRAM allocations.<br>
                                  </div>
                                  <div><br>
                                  </div>
                                  <div>1. No list is exposed. Only sums
                                    of buffer sizes are exposed. Also,
                                    the eviction list has no meaning
                                    here. All lists are treated equally,
                                    and mem_type is compared with
                                    preferred_domains to determine where
                                    buffers are and where they should
                                    be.<br>
                                  </div>
                                  <div><br>
                                  </div>
                                  <div>2. I'm not interested in the
                                    overcommit value. I'm only
                                    interested in knowing the number of
                                    bytes of evicted VRAM right now. It
                                    can be as variable as the CPU load,
                                    but in practice it shouldn't be
                                    because PCIe doesn't have the
                                    bandwidth to move things quickly.<br>
                                  </div>
                                  <div><br>
                                  </div>
                                  <div>3. Yes, that's true.</div>
                                  <div><br>
                                  </div>
                                  <div>Marek</div>
                                  <br>
                                </div>
                              </div>
                            </blockquote>
                          </div>
                        </blockquote>
                        <br>
                      </div>
                    </blockquote>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------TRlaO7dvMo4gt4UcxnXTrmBY--
