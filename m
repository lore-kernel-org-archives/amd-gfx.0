Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74494C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F298910E5E3;
	Tue, 10 Jan 2023 15:28:50 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AF310E5E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:28:48 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id v10so16854539edi.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tp357G8cYrndYd8cLdQjaiZPQmtmQ0CTs5dEXDKfXt8=;
 b=jgqfos00YBcCug1bVJhEHKTHp6JcdIaJVTM3ddgos9OeicsrbrJ81ZzS8BWlNYEuz4
 WfoWbORWFt9mFTMpicTskgN+vAvjVkURBCMi8HPzsMHaPmle8niZds+r7VojEvj7AtzX
 c5uKH4HB6yFQxcGHHsUcvIZK/xT92VPt6tNXMr0Dhf0gcCR6ANKE26G04KHVVy12lW3B
 D5GSmIdQd4o4/ZlFxWZHz0ZIC6fqEKufudETqrdwDVIMuYqoMhmbrZRzPK2xZGWTu5hX
 U5oJM5COtmRv/fDylaYQkYwB5PQ2G2Bj4QJUvlyWLR+PWRaXlgxTN54R/Z9w71aAyu/J
 PW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tp357G8cYrndYd8cLdQjaiZPQmtmQ0CTs5dEXDKfXt8=;
 b=vnPJv5115dn7nzA25Hj4wkOepdYt9tfvYIAbgDJnmWUi8WiYgySWwhv4M0zsBNTLDD
 Nsr8Ng/rbd36oiEFfo64gGkpiQLNlo5hQqc6reikI20VT37kzIadUnvXsnsPRE7jFMnq
 qftTOZ3P9G9mEkBoX/ly1i4EiYWcA9yCUwV/f0d9XrJpD0zYThALUgTTlRXiTNzIuoau
 nyegkGiPbvtlqdZ9Etc0LoB6rejCzAukx78syjSEsgedYZx3lWWfvhM6kP+kifWotbRo
 ybLEK2aqIkIBw54W0EkYzAnVbJHgLn4AHC7AXcF4Ec6H2Dde6DUKv3Zu5shap2ot5IKK
 hzGw==
X-Gm-Message-State: AFqh2koeadBMNq/cAwHUKHHF5W/ZS18dEHxwVccc8pgww4Eu/wksFi/g
 O7fAiN+bv0FybaoHJxSBgnxvWFhpCrPJ8RLunvGR9B0U
X-Google-Smtp-Source: AMrXdXuaHwQqEFKk2LObFxE4wDMjwH9mmCtHiqfg56rISnugC/42ypEpfxGKtyG4zYWlT8dlL1XFWfu79METHnfZO00=
X-Received: by 2002:aa7:cd89:0:b0:497:b04c:f270 with SMTP id
 x9-20020aa7cd89000000b00497b04cf270mr1716772edv.344.1673364526750; Tue, 10
 Jan 2023 07:28:46 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
 <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
 <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
 <CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com>
 <d1463910-1eab-2dac-a633-812ada011cc4@gmail.com>
In-Reply-To: <d1463910-1eab-2dac-a633-812ada011cc4@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 10 Jan 2023 10:28:10 -0500
Message-ID: <CAAxE2A5fWDp==muWuXSXuGGHtT_RThLpC1rK92c2mLVLdmGdUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003261fd05f1ea8a7d"
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

--0000000000003261fd05f1ea8a7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 4, 2023 at 9:51 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 04.01.23 um 00:08 schrieb Marek Ol=C5=A1=C3=A1k:
>
> I see about the access now, but did you even look at the patch?
>
>
> I did look at the patch, but I haven't fully understood yet what you are
> trying to do here.
>

First and foremost, it returns the evicted size of VRAM and visible VRAM,
and returns visible VRAM usage. It should be obvious which stat includes
the size of another.


> Because what the patch does isn't even exposed to common drm code, such a=
s
> the preferred domain and visible VRAM placement, so it can't be in fdinfo
> right now.
>
> Or do you even know what fdinfo contains? Because it contains nothing
> useful. It only has VRAM and GTT usage, which we already have in the INFO
> ioctl, so it has nothing that we need. We mainly need the eviction
> information and visible VRAM information now. Everything else is a bonus.
>
>
> Well the main question is what are you trying to get from that
> information? The eviction list for example is completely meaningless to
> userspace, that stuff is only temporary and will be cleared on the next C=
S
> again.
>

I don't know what you mean. The returned eviction stats look correct and
are stable (they don't change much). You can suggest changes if you think
some numbers are not reported correctly.


>
> What we could expose is the VRAM over-commit value, e.g. how much BOs
> which where supposed to be in VRAM are in GTT now. I think that's what yo=
u
> are looking for here, right?
>

The VRAM overcommit value is "evicted_vram".


>
> Also, it's undesirable to open and parse a text file if we can just call
> an ioctl.
>
>
> Well I see the reasoning for that, but I also see why other drivers do a
> lot of the stuff we have as IOCTL as separate files in sysfs, fdinfo or
> debugfs.
>
> Especially repeating all the static information which were already
> available under sysfs in the INFO IOCTL was a design mistake as far as I
> can see. Just compare what AMDGPU and the KFD code is doing to what for
> example i915 is doing.
>
> Same for things like debug information about a process. The fdinfo stuff
> can be queried from external tools (gdb, gputop, umr etc...) as well whic=
h
> makes that interface more preferred.
>

Nothing uses fdinfo in Mesa. No driver uses sysfs in Mesa except drm shims,
noop drivers, and Intel for perf metrics. sysfs itself is an unusable mess
for the PCIe query and is missing information.

I'm not against exposing more stuff through sysfs and fdinfo for tools, but
I don't see any reason why drivers should use it (other than for slowing
down queries and initialization).

Marek

--0000000000003261fd05f1ea8a7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Jan 4, 2023 at 9:51 AM Christian K=C3=B6nig &lt;<a href=3D"m=
ailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Am 04.01.23 um 00:08 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>I see about the access now, but did you even look at the
          patch?</div>
      </div>
    </blockquote>
    <br>
    I did look at the patch, but I haven&#39;t fully understood yet what yo=
u
    are trying to do here.<br></div></blockquote><div><br></div><div>First =
and foremost, it returns the evicted size of VRAM and visible VRAM, and ret=
urns visible VRAM usage. It should be obvious which stat includes the size =
of another.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div> Because what the patch does isn&#39;t even exposed to common
          drm code, such as the preferred domain and visible VRAM
          placement, so it can&#39;t be in fdinfo right now.<br>
        </div>
        <div><br>
        </div>
        <div>Or do you even know what fdinfo contains? Because it
          contains nothing useful. It only has VRAM and GTT usage, which
          we already have in the INFO ioctl, so it has nothing that we
          need. We mainly need the eviction information and visible VRAM
          information now. Everything else is a bonus.<br>
        </div>
      </div>
    </blockquote>
    <br>
    Well the main question is what are you trying to get from that
    information? The eviction list for example is completely meaningless
    to userspace, that stuff is only temporary and will be cleared on
    the next CS again.<br></div></blockquote><div><br></div><div>I don&#39;=
t know what you mean. The returned eviction stats look correct and are stab=
le (they don&#39;t change much). You can suggest changes if you think some =
numbers are not reported correctly.<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div>
    <br>
    What we could expose is the VRAM over-commit value, e.g. how much
    BOs which where supposed to be in VRAM are in GTT now. I think
    that&#39;s what you are looking for here, right?<br></div></blockquote>=
<div><br></div><div>The VRAM overcommit value is &quot;evicted_vram&quot;.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>Also, it&#39;s undesirable to open and parse a text file if
            we can just call an ioctl.</div>
        </div>
      </div>
    </blockquote>
    <br>
    Well I see the reasoning for that, but I also see why other drivers
    do a lot of the stuff we have as IOCTL as separate files in sysfs,
    fdinfo or debugfs.<br>
    <br>
    Especially repeating all the static information which were already
    available under sysfs in the INFO IOCTL was a design mistake as far
    as I can see. Just compare what AMDGPU and the KFD code is doing to
    what for example i915 is doing.<br>
    <br>
    Same for things like debug information about a process. The fdinfo
    stuff can be queried from external tools (gdb, gputop, umr etc...)
    as well which makes that interface more preferred.<br></div></blockquot=
e><div><br></div><div>Nothing uses fdinfo in Mesa. No driver uses sysfs in =
Mesa except drm shims, noop drivers, and Intel for perf metrics. sysfs itse=
lf is an unusable mess for the PCIe query and is missing information.</div>=
<div><br></div><div>I&#39;m not against exposing more stuff through sysfs a=
nd fdinfo for tools, but I don&#39;t see any reason why drivers should use =
it (other than for slowing down queries and initialization).</div><div><br>=
</div><div>Marek</div></div></div>

--0000000000003261fd05f1ea8a7d--
