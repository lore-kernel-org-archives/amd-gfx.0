Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65411C25B4E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 07:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B7B10E612;
	Tue, 24 Jan 2023 07:37:40 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5064C10E612
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 07:37:38 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id hw16so36586848ejc.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 23:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9AIB4pYc7BmjdkAZmOpHmsTGHIlrKuBk27cLbE48OPQ=;
 b=pG4bekXkqMwhB/01o34Iicm8C6d1RBzm7TZqlJvq1Yok0bLgCpb97c1wljB/vALMR6
 3ODSrUbdj9sVhpKehv6rwK07n9Qs2YSN/MnMrMaT78nYa8b5Br3nl7ikh7P7EugkW2iL
 fdEobArzqoNQavC7tvX/7BWVHdGLYl+yyKu6UJCZElKOarHTA4T6XHl1V1j4Zab+1QqW
 UxHTN2qypT0xPS64ehNqXShxPJ0XlerTU4qleRY6ShI3Hsi06lSlXnhnXxqk4RFzWUYb
 bdvG8vGG6rUyjKNSYoufAFjDeJdxbc29GfYLuTHGtdazfCVWo6Gk+jKBdLYVWvptjkul
 RNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9AIB4pYc7BmjdkAZmOpHmsTGHIlrKuBk27cLbE48OPQ=;
 b=IZlWYnjywSFsVQmg5crjpgJd00BpYoZaEY1JdGijBqVyuQdhb670dS4dlYsDdJgosa
 OGAPDLzDgTmgQGB2JTz121UuYDhelCs13sP3pHynNUlrpydqJmuNliBN3YOPv1SSn/ls
 Vh0sd/tZO6V4ElEvD+A/n/G5YWV0TlJ6m1xsJt6ik7YvbWGPZnPG6SvpDuzOD54GjmCq
 oFh44bdyBv/UZW9YQd5wpVDt1IJmL2LJharFthHM1klhCmT48IFNDAiL3Us7CkHFxnzh
 3yjZ5jiQCyJ6/76sknUDafc8z4qD1jKODWFm3vAM6BhBihGqlJBONV507iHjXVgKIcJq
 Ewgw==
X-Gm-Message-State: AFqh2koRLQGGSgroWFS9oShH9LjN3WRUc+JzFg3wKS1yFSFmF5mi2rZo
 D085Q8wyrHRNWjwZHEm9v8uzbRLvgyZsc17dtP1IFnPf
X-Google-Smtp-Source: AMrXdXufLLjqbi29PGLquPNFwIKlbqZWPgnlPbTUdY2u+/RkRT3x+XuyQIFu8kxrcpfXRtlUn2/R7hg7rmu4CyvIyqo=
X-Received: by 2002:a17:906:eb16:b0:86c:3978:65ca with SMTP id
 mb22-20020a170906eb1600b0086c397865camr2660182ejb.320.1674545856641; Mon, 23
 Jan 2023 23:37:36 -0800 (PST)
MIME-Version: 1.0
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
In-Reply-To: <4992933e-ad45-5f7a-b7af-39c6d0948321@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 24 Jan 2023 02:37:00 -0500
Message-ID: <CAAxE2A4rxdVqYp5qvN4DyV-=9TxE6EgeXPu++=7f1BEEhOs+Bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f2002905f2fd96e4"
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

--000000000000f2002905f2fd96e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Gallium HUD doesn't consume strings. It only consumes values that are
exposed as counters from the driver. In this case, we need the driver to
expose evicted stats as counters. Each counter can set whether the value is
absolute (e.g. memory usage) or monotonic (e.g. perf counter). Parsing
fdinfo to get the values is undesirable.

Marek

On Mon, Jan 23, 2023 at 4:31 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Let's do this as valid in fdinfo.
>
> This way we can easily extend whatever the kernel wants to display as
> statistics in the userspace HUD.
>
> Regards,
> Christian.
>
> Am 21.01.23 um 01:45 schrieb Marek Ol=C5=A1=C3=A1k:
>
> We badly need a way to query evicted memory usage. It's essential for
> investigating performance problems and it uncovered the buddy allocator
> disaster. Please either suggest an alternative, suggest changes, or revie=
w.
> We need it ASAP.
>
> Thanks,
> Marek
>
> On Tue, Jan 10, 2023 at 11:55 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
>
>> On Tue, Jan 10, 2023 at 11:23 AM Christian K=C3=B6nig <
>> ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>> Am 10.01.23 um 16:28 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> On Wed, Jan 4, 2023 at 9:51 AM Christian K=C3=B6nig <
>>> ckoenig.leichtzumerken@gmail.com> wrote:
>>>
>>>> Am 04.01.23 um 00:08 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>
>>>> I see about the access now, but did you even look at the patch?
>>>>
>>>>
>>>> I did look at the patch, but I haven't fully understood yet what you
>>>> are trying to do here.
>>>>
>>>
>>> First and foremost, it returns the evicted size of VRAM and visible
>>> VRAM, and returns visible VRAM usage. It should be obvious which stat
>>> includes the size of another.
>>>
>>>
>>>> Because what the patch does isn't even exposed to common drm code, suc=
h
>>>> as the preferred domain and visible VRAM placement, so it can't be in
>>>> fdinfo right now.
>>>>
>>>> Or do you even know what fdinfo contains? Because it contains nothing
>>>> useful. It only has VRAM and GTT usage, which we already have in the I=
NFO
>>>> ioctl, so it has nothing that we need. We mainly need the eviction
>>>> information and visible VRAM information now. Everything else is a bon=
us.
>>>>
>>>>
>>>> Well the main question is what are you trying to get from that
>>>> information? The eviction list for example is completely meaningless t=
o
>>>> userspace, that stuff is only temporary and will be cleared on the nex=
t CS
>>>> again.
>>>>
>>>
>>> I don't know what you mean. The returned eviction stats look correct an=
d
>>> are stable (they don't change much). You can suggest changes if you thi=
nk
>>> some numbers are not reported correctly.
>>>
>>>
>>>>
>>>> What we could expose is the VRAM over-commit value, e.g. how much BOs
>>>> which where supposed to be in VRAM are in GTT now. I think that's what=
 you
>>>> are looking for here, right?
>>>>
>>>
>>> The VRAM overcommit value is "evicted_vram".
>>>
>>>
>>>>
>>>> Also, it's undesirable to open and parse a text file if we can just
>>>> call an ioctl.
>>>>
>>>>
>>>> Well I see the reasoning for that, but I also see why other drivers do
>>>> a lot of the stuff we have as IOCTL as separate files in sysfs, fdinfo=
 or
>>>> debugfs.
>>>>
>>>> Especially repeating all the static information which were already
>>>> available under sysfs in the INFO IOCTL was a design mistake as far as=
 I
>>>> can see. Just compare what AMDGPU and the KFD code is doing to what fo=
r
>>>> example i915 is doing.
>>>>
>>>> Same for things like debug information about a process. The fdinfo
>>>> stuff can be queried from external tools (gdb, gputop, umr etc...) as =
well
>>>> which makes that interface more preferred.
>>>>
>>>
>>> Nothing uses fdinfo in Mesa. No driver uses sysfs in Mesa except drm
>>> shims, noop drivers, and Intel for perf metrics. sysfs itself is an
>>> unusable mess for the PCIe query and is missing information.
>>>
>>> I'm not against exposing more stuff through sysfs and fdinfo for tools,
>>> but I don't see any reason why drivers should use it (other than for
>>> slowing down queries and initialization).
>>>
>>>
>>> That's what I'm asking: Is this for some tool or to make some driver
>>> decision based on it?
>>>
>>> If you just want the numbers for over displaying then I think it would
>>> be better to put this into fdinfo together with the other existing stuf=
f
>>> there.
>>>
>>
>>> If you want to make allocation decisions based on this then we should
>>> have that as IOCTL or even better as mmap() page between kernel and
>>> userspace. But in this case I would also calculation the numbers comple=
tely
>>> different as well.
>>>
>>> See we have at least the following things in the kernel:
>>> 1. The eviction list in the VM.
>>>     Those are the BOs which are currently evicted and tried to moved
>>> back in on the next CS.
>>>
>>> 2. The VRAM over commit value.
>>>     In other words how much more VRAM than available has the applicatio=
n
>>> tried to allocate?
>>>
>>> 3. The visible VRAM usage by this application.
>>>
>>> The end goal is that the eviction list will go away, e.g. we will alway=
s
>>> have stable allocations based on allocations of other applications and =
not
>>> constantly swap things in and out.
>>>
>>> When you now expose the eviction list to userspace we will be stuck wit=
h
>>> this interface forever.
>>>
>>
>> It's for the GALLIUM HUD.
>>
>> The only missing thing is the size of all evicted VRAM allocations, and
>> the size of all evicted visible VRAM allocations.
>>
>> 1. No list is exposed. Only sums of buffer sizes are exposed. Also, the
>> eviction list has no meaning here. All lists are treated equally, and
>> mem_type is compared with preferred_domains to determine where buffers a=
re
>> and where they should be.
>>
>> 2. I'm not interested in the overcommit value. I'm only interested in
>> knowing the number of bytes of evicted VRAM right now. It can be as
>> variable as the CPU load, but in practice it shouldn't be because PCIe
>> doesn't have the bandwidth to move things quickly.
>>
>> 3. Yes, that's true.
>>
>> Marek
>>
>>
>

--000000000000f2002905f2fd96e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The Gallium HUD doesn&#39;t consume strings. It only =
consumes values that are exposed as counters from the driver. In this case,=
 we need the driver to expose evicted stats as counters. Each counter can s=
et whether the value is absolute (e.g. memory usage) or monotonic (e.g. per=
f counter). Parsing fdinfo to get the values is undesirable.<br></div><div>=
<br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jan 23, 2023 at 4:31 AM Christian K=
=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.l=
eichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Let&#39;s do this as valid in fdinfo.<br>
    <br>
    This way we can easily extend whatever the kernel wants to display
    as statistics in the userspace HUD.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div>Am 21.01.23 um 01:45 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>We badly need a way to query evicted memory usage. It&#39;s
          essential for investigating performance problems and it
          uncovered the buddy allocator disaster. Please either suggest
          an alternative, suggest changes, or review. We need it ASAP.<br>
        </div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 10, 2023 at 11:55
          AM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" =
target=3D"_blank">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <div class=3D"gmail_quote">
              <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 10, 2023 at
                11:23 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig=
.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.c=
om</a>&gt;
                wrote:<br>
              </div>
              <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                <div> Am 10.01.23 um 16:28 schrieb Marek Ol=C5=A1=C3=A1k:<b=
r>
                  <blockquote type=3D"cite">
                    <div dir=3D"ltr">
                      <div class=3D"gmail_quote">
                        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 4=
,
                          2023 at 9:51 AM Christian K=C3=B6nig &lt;<a href=
=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leic=
htzumerken@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          <div> Am 04.01.23 um 00:08 schrieb Marek
                            Ol=C5=A1=C3=A1k:<br>
                            <blockquote type=3D"cite">
                              <div dir=3D"ltr">
                                <div>I see about the access now, but did
                                  you even look at the patch?</div>
                              </div>
                            </blockquote>
                            <br>
                            I did look at the patch, but I haven&#39;t full=
y
                            understood yet what you are trying to do
                            here.<br>
                          </div>
                        </blockquote>
                        <div><br>
                        </div>
                        <div>First and foremost, it returns the evicted
                          size of VRAM and visible VRAM, and returns
                          visible VRAM usage. It should be obvious which
                          stat includes the size of another.<br>
                        </div>
                        <div><br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          <div> <br>
                            <blockquote type=3D"cite">
                              <div dir=3D"ltr">
                                <div> Because what the patch does isn&#39;t
                                  even exposed to common drm code, such
                                  as the preferred domain and visible
                                  VRAM placement, so it can&#39;t be in
                                  fdinfo right now.<br>
                                </div>
                                <div><br>
                                </div>
                                <div>Or do you even know what fdinfo
                                  contains? Because it contains nothing
                                  useful. It only has VRAM and GTT
                                  usage, which we already have in the
                                  INFO ioctl, so it has nothing that we
                                  need. We mainly need the eviction
                                  information and visible VRAM
                                  information now. Everything else is a
                                  bonus.<br>
                                </div>
                              </div>
                            </blockquote>
                            <br>
                            Well the main question is what are you
                            trying to get from that information? The
                            eviction list for example is completely
                            meaningless to userspace, that stuff is only
                            temporary and will be cleared on the next CS
                            again.<br>
                          </div>
                        </blockquote>
                        <div><br>
                        </div>
                        <div>I don&#39;t know what you mean. The returned
                          eviction stats look correct and are stable
                          (they don&#39;t change much). You can suggest
                          changes if you think some numbers are not
                          reported correctly.<br>
                        </div>
                        <div>=C2=A0</div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          <div> <br>
                            What we could expose is the VRAM over-commit
                            value, e.g. how much BOs which where
                            supposed to be in VRAM are in GTT now. I
                            think that&#39;s what you are looking for here,
                            right?<br>
                          </div>
                        </blockquote>
                        <div><br>
                        </div>
                        <div>The VRAM overcommit value is
                          &quot;evicted_vram&quot;.<br>
                        </div>
                        <div>=C2=A0</div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          <div> <br>
                            <blockquote type=3D"cite">
                              <div dir=3D"ltr">
                                <div>
                                  <div>Also, it&#39;s undesirable to open
                                    and parse a text file if we can just
                                    call an ioctl.</div>
                                </div>
                              </div>
                            </blockquote>
                            <br>
                            Well I see the reasoning for that, but I
                            also see why other drivers do a lot of the
                            stuff we have as IOCTL as separate files in
                            sysfs, fdinfo or debugfs.<br>
                            <br>
                            Especially repeating all the static
                            information which were already available
                            under sysfs in the INFO IOCTL was a design
                            mistake as far as I can see. Just compare
                            what AMDGPU and the KFD code is doing to
                            what for example i915 is doing.<br>
                            <br>
                            Same for things like debug information about
                            a process. The fdinfo stuff can be queried
                            from external tools (gdb, gputop, umr
                            etc...) as well which makes that interface
                            more preferred.<br>
                          </div>
                        </blockquote>
                        <div><br>
                        </div>
                        <div>Nothing uses fdinfo in Mesa. No driver uses
                          sysfs in Mesa except drm shims, noop drivers,
                          and Intel for perf metrics. sysfs itself is an
                          unusable mess for the PCIe query and is
                          missing information.</div>
                        <div><br>
                        </div>
                        <div>I&#39;m not against exposing more stuff throug=
h
                          sysfs and fdinfo for tools, but I don&#39;t see
                          any reason why drivers should use it (other
                          than for slowing down queries and
                          initialization).</div>
                      </div>
                    </div>
                  </blockquote>
                  <br>
                  That&#39;s what I&#39;m asking: Is this for some tool or =
to
                  make some driver decision based on it?<br>
                  <br>
                  If you just want the numbers for over displaying then
                  I think it would be better to put this into fdinfo
                  together with the other existing stuff there.<br>
                </div>
              </blockquote>
              <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                <div> <br>
                  If you want to make allocation decisions based on this
                  then we should have that as IOCTL or even better as
                  mmap() page between kernel and userspace. But in this
                  case I would also calculation the numbers completely
                  different as well.<br>
                  <br>
                  See we have at least the following things in the
                  kernel:<br>
                  1. The eviction list in the VM.<br>
                  =C2=A0=C2=A0=C2=A0 Those are the BOs which are currently =
evicted and
                  tried to moved back in on the next CS.<br>
                  <br>
                  2. The VRAM over commit value.<br>
                  =C2=A0=C2=A0=C2=A0 In other words how much more VRAM than=
 available
                  has the application tried to allocate?<br>
                  <br>
                  3. The visible VRAM usage by this application.<br>
                  <br>
                  The end goal is that the eviction list will go away,
                  e.g. we will always have stable allocations based on
                  allocations of other applications and not constantly
                  swap things in and out.<br>
                  <br>
                  When you now expose the eviction list to userspace we
                  will be stuck with this interface forever.<br>
                </div>
              </blockquote>
              <div><br>
              </div>
              <div>It&#39;s for the GALLIUM HUD.</div>
              <div><br>
              </div>
              <div>The only missing thing is the size of all evicted
                VRAM allocations, and the size of all evicted visible
                VRAM allocations.<br>
              </div>
              <div><br>
              </div>
              <div>1. No list is exposed. Only sums of buffer sizes are
                exposed. Also, the eviction list has no meaning here.
                All lists are treated equally, and mem_type is compared
                with preferred_domains to determine where buffers are
                and where they should be.<br>
              </div>
              <div><br>
              </div>
              <div>2. I&#39;m not interested in the overcommit value. I&#39=
;m
                only interested in knowing the number of bytes of
                evicted VRAM right now. It can be as variable as the CPU
                load, but in practice it shouldn&#39;t be because PCIe
                doesn&#39;t have the bandwidth to move things quickly.<br>
              </div>
              <div><br>
              </div>
              <div>3. Yes, that&#39;s true.</div>
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

</blockquote></div>

--000000000000f2002905f2fd96e4--
