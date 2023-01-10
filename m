Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6406C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333F310E607;
	Tue, 10 Jan 2023 16:56:25 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C69110E608
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:23 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id az20so11252896ejc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LIdaCEfGmr2feDjsujBA+yiZoQF3RTPK1+x7tHaVBzA=;
 b=Dwq6Jopw6FFLpUH/V6udPUFu+KxU1OYhCO3RKNhF5oQE/NYGCuj1xM5dcUOlaB0QYS
 2lBXJC4c5dc0TZylYJndQruD9YDd0ijgG1P9sn1WoPyNvB6z0zIkSTpt6VJX8JsunxjN
 dPqtx6uN10dHStPmaB9oNyWmzkxbfZfHKwOnuDx9oW/Ch99CjxBiAwb6aUt74C0bVCyG
 GaH4f2ShGV9PKuJPl93VQlXQJY8SUHm+NtofMYTWyjQeRZg1Bs+yKsF7WizY4erS2Bkf
 +ShTlntqeUWwnuqNj5SRdTwHk3cxmc5nsX1yoZGXpptkYIHdzFsGoSqr0exw7gjeR/q+
 Zk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LIdaCEfGmr2feDjsujBA+yiZoQF3RTPK1+x7tHaVBzA=;
 b=UdcItKn0hMa9ATQXcy/YF3t8aFComkXi73Vjpvh54AmX0hd7CHpZ2C0cCDbVQrQNoj
 N2oWjlYHbeFP6TU5Ac/85wCS+0jHWB8AF3garKakVeKnf6e2r80fSJHv+zVcra07Vjp4
 8NX6IxzGTApVvyCn50wV+X3vO9+74/uwrO+eK52RNj3WvqARuHKJ63ONtSEjGDjFoCuN
 YQPFRgvzOo8CNxRm5AG5HTnI45RKMnzTKcKIjx/FOre9UnsGEmtATZfwMS/gK+BgNbgD
 TscdvwQELDSR+hFPsjUQ8Tjl2ELOdrNGAialHW4pGb4ydoqOFq6lQqUKmhRbJ03CNM6H
 krFA==
X-Gm-Message-State: AFqh2kqw1uzqdHCr+1K26vnGzIV0ozzyEEdm8akKwTJriHx9q7BaS5i7
 r+IcSww6hMg5w8jyYYh6tuLBWvldh6sx4M7inn78numJBYM=
X-Google-Smtp-Source: AMrXdXtawvDKWBPpoMqB/8+Np+Vrt0Dv7gAS0t65kkQmz+EJvlLo2L854uX0ELB0IO/v8KujYUZqCHKlE0xVRDqeNEw=
X-Received: by 2002:a17:906:40cf:b0:7c1:ff6:615b with SMTP id
 a15-20020a17090640cf00b007c10ff6615bmr4024638ejk.118.1673369781996; Tue, 10
 Jan 2023 08:56:21 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
 <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
 <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
 <CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com>
 <d1463910-1eab-2dac-a633-812ada011cc4@gmail.com>
 <CAAxE2A5fWDp==muWuXSXuGGHtT_RThLpC1rK92c2mLVLdmGdUQ@mail.gmail.com>
 <fe0ca4a4-b339-20ab-fd42-68b2a5e00e9c@gmail.com>
In-Reply-To: <fe0ca4a4-b339-20ab-fd42-68b2a5e00e9c@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 10 Jan 2023 11:55:45 -0500
Message-ID: <CAAxE2A71r9sQqFCPajK2VhL5GBJZ=Js5YRvYkrrsRtTRT5yxTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006f26cb05f1ebc349"
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

--0000000000006f26cb05f1ebc349
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2023 at 11:23 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 10.01.23 um 16:28 schrieb Marek Ol=C5=A1=C3=A1k:
>
> On Wed, Jan 4, 2023 at 9:51 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Am 04.01.23 um 00:08 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> I see about the access now, but did you even look at the patch?
>>
>>
>> I did look at the patch, but I haven't fully understood yet what you are
>> trying to do here.
>>
>
> First and foremost, it returns the evicted size of VRAM and visible VRAM,
> and returns visible VRAM usage. It should be obvious which stat includes
> the size of another.
>
>
>> Because what the patch does isn't even exposed to common drm code, such
>> as the preferred domain and visible VRAM placement, so it can't be in
>> fdinfo right now.
>>
>> Or do you even know what fdinfo contains? Because it contains nothing
>> useful. It only has VRAM and GTT usage, which we already have in the INF=
O
>> ioctl, so it has nothing that we need. We mainly need the eviction
>> information and visible VRAM information now. Everything else is a bonus=
.
>>
>>
>> Well the main question is what are you trying to get from that
>> information? The eviction list for example is completely meaningless to
>> userspace, that stuff is only temporary and will be cleared on the next =
CS
>> again.
>>
>
> I don't know what you mean. The returned eviction stats look correct and
> are stable (they don't change much). You can suggest changes if you think
> some numbers are not reported correctly.
>
>
>>
>> What we could expose is the VRAM over-commit value, e.g. how much BOs
>> which where supposed to be in VRAM are in GTT now. I think that's what y=
ou
>> are looking for here, right?
>>
>
> The VRAM overcommit value is "evicted_vram".
>
>
>>
>> Also, it's undesirable to open and parse a text file if we can just call
>> an ioctl.
>>
>>
>> Well I see the reasoning for that, but I also see why other drivers do a
>> lot of the stuff we have as IOCTL as separate files in sysfs, fdinfo or
>> debugfs.
>>
>> Especially repeating all the static information which were already
>> available under sysfs in the INFO IOCTL was a design mistake as far as I
>> can see. Just compare what AMDGPU and the KFD code is doing to what for
>> example i915 is doing.
>>
>> Same for things like debug information about a process. The fdinfo stuff
>> can be queried from external tools (gdb, gputop, umr etc...) as well whi=
ch
>> makes that interface more preferred.
>>
>
> Nothing uses fdinfo in Mesa. No driver uses sysfs in Mesa except drm
> shims, noop drivers, and Intel for perf metrics. sysfs itself is an
> unusable mess for the PCIe query and is missing information.
>
> I'm not against exposing more stuff through sysfs and fdinfo for tools,
> but I don't see any reason why drivers should use it (other than for
> slowing down queries and initialization).
>
>
> That's what I'm asking: Is this for some tool or to make some driver
> decision based on it?
>
> If you just want the numbers for over displaying then I think it would be
> better to put this into fdinfo together with the other existing stuff the=
re.
>

> If you want to make allocation decisions based on this then we should hav=
e
> that as IOCTL or even better as mmap() page between kernel and userspace.
> But in this case I would also calculation the numbers completely differen=
t
> as well.
>
> See we have at least the following things in the kernel:
> 1. The eviction list in the VM.
>     Those are the BOs which are currently evicted and tried to moved back
> in on the next CS.
>
> 2. The VRAM over commit value.
>     In other words how much more VRAM than available has the application
> tried to allocate?
>
> 3. The visible VRAM usage by this application.
>
> The end goal is that the eviction list will go away, e.g. we will always
> have stable allocations based on allocations of other applications and no=
t
> constantly swap things in and out.
>
> When you now expose the eviction list to userspace we will be stuck with
> this interface forever.
>

It's for the GALLIUM HUD.

The only missing thing is the size of all evicted VRAM allocations, and the
size of all evicted visible VRAM allocations.

1. No list is exposed. Only sums of buffer sizes are exposed. Also, the
eviction list has no meaning here. All lists are treated equally, and
mem_type is compared with preferred_domains to determine where buffers are
and where they should be.

2. I'm not interested in the overcommit value. I'm only interested in
knowing the number of bytes of evicted VRAM right now. It can be as
variable as the CPU load, but in practice it shouldn't be because PCIe
doesn't have the bandwidth to move things quickly.

3. Yes, that's true.

Marek

--0000000000006f26cb05f1ebc349
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Jan 10, 2023 at 11:23 AM Christian K=C3=B6nig &lt;<a href=3D=
"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Am 10.01.23 um 16:28 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 4, 2023 at 9:51
            AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzum=
erken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> Am 04.01.23 um 00:08 schrieb Marek Ol=C5=A1=C3=A1k:<br>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div>I see about the access now, but did you even look
                    at the patch?</div>
                </div>
              </blockquote>
              <br>
              I did look at the patch, but I haven&#39;t fully understood
              yet what you are trying to do here.<br>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>First and foremost, it returns the evicted size of VRAM
            and visible VRAM, and returns visible VRAM usage. It should
            be obvious which stat includes the size of another.<br>
          </div>
          <div><br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> <br>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div> Because what the patch does isn&#39;t even exposed
                    to common drm code, such as the preferred domain and
                    visible VRAM placement, so it can&#39;t be in fdinfo
                    right now.<br>
                  </div>
                  <div><br>
                  </div>
                  <div>Or do you even know what fdinfo contains? Because
                    it contains nothing useful. It only has VRAM and GTT
                    usage, which we already have in the INFO ioctl, so
                    it has nothing that we need. We mainly need the
                    eviction information and visible VRAM information
                    now. Everything else is a bonus.<br>
                  </div>
                </div>
              </blockquote>
              <br>
              Well the main question is what are you trying to get from
              that information? The eviction list for example is
              completely meaningless to userspace, that stuff is only
              temporary and will be cleared on the next CS again.<br>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>I don&#39;t know what you mean. The returned eviction stats
            look correct and are stable (they don&#39;t change much). You
            can suggest changes if you think some numbers are not
            reported correctly.<br>
          </div>
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> <br>
              What we could expose is the VRAM over-commit value, e.g.
              how much BOs which where supposed to be in VRAM are in GTT
              now. I think that&#39;s what you are looking for here, right?=
<br>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>The VRAM overcommit value is &quot;evicted_vram&quot;.<br>
          </div>
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> <br>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div>
                    <div>Also, it&#39;s undesirable to open and parse a tex=
t
                      file if we can just call an ioctl.</div>
                  </div>
                </div>
              </blockquote>
              <br>
              Well I see the reasoning for that, but I also see why
              other drivers do a lot of the stuff we have as IOCTL as
              separate files in sysfs, fdinfo or debugfs.<br>
              <br>
              Especially repeating all the static information which were
              already available under sysfs in the INFO IOCTL was a
              design mistake as far as I can see. Just compare what
              AMDGPU and the KFD code is doing to what for example i915
              is doing.<br>
              <br>
              Same for things like debug information about a process.
              The fdinfo stuff can be queried from external tools (gdb,
              gputop, umr etc...) as well which makes that interface
              more preferred.<br>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>Nothing uses fdinfo in Mesa. No driver uses sysfs in Mesa
            except drm shims, noop drivers, and Intel for perf metrics.
            sysfs itself is an unusable mess for the PCIe query and is
            missing information.</div>
          <div><br>
          </div>
          <div>I&#39;m not against exposing more stuff through sysfs and
            fdinfo for tools, but I don&#39;t see any reason why drivers
            should use it (other than for slowing down queries and
            initialization).</div>
        </div>
      </div>
    </blockquote>
    <br>
    That&#39;s what I&#39;m asking: Is this for some tool or to make some d=
river
    decision based on it?<br>
    <br>
    If you just want the numbers for over displaying then I think it
    would be better to put this into fdinfo together with the other
    existing stuff there.<br></div></blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div>
    <br>
    If you want to make allocation decisions based on this then we
    should have that as IOCTL or even better as mmap() page between
    kernel and userspace. But in this case I would also calculation the
    numbers completely different as well.<br>
    <br>
    See we have at least the following things in the kernel:<br>
    1. The eviction list in the VM.<br>
    =C2=A0=C2=A0=C2=A0 Those are the BOs which are currently evicted and tr=
ied to moved
    back in on the next CS.<br>
    <br>
    2. The VRAM over commit value.<br>
    =C2=A0=C2=A0=C2=A0 In other words how much more VRAM than available has=
 the
    application tried to allocate?<br>
    <br>
    3. The visible VRAM usage by this application.<br>
    <br>
    The end goal is that the eviction list will go away, e.g. we will
    always have stable allocations based on allocations of other
    applications and not constantly swap things in and out.<br>
    <br>
    When you now expose the eviction list to userspace we will be stuck
    with this interface forever.<br></div></blockquote><div><br></div><div>=
It&#39;s for the GALLIUM HUD.</div><div><br></div><div>The only missing thi=
ng is the size of all evicted VRAM allocations, and the size of all evicted=
 visible VRAM allocations.<br></div><div><br></div><div>1. No list is expos=
ed. Only sums of buffer sizes are exposed. Also, the eviction list has no m=
eaning here. All lists are treated equally, and mem_type is compared with p=
referred_domains to determine where buffers are and where they should be.<b=
r></div><div><br></div><div>2. I&#39;m not interested in the overcommit val=
ue. I&#39;m only interested in knowing the number of bytes of evicted VRAM =
right now. It can be as variable as the CPU load, but in practice it should=
n&#39;t be because PCIe doesn&#39;t have the bandwidth to move things quick=
ly.<br></div><div><br></div><div>3. Yes, that&#39;s true.</div><div><br></d=
iv><div>Marek</div><br></div></div>

--0000000000006f26cb05f1ebc349--
