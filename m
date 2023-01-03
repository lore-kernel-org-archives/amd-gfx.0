Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8AFC4708E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 23:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C99610E285;
	Tue,  3 Jan 2023 23:08:46 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483E710E285
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 23:08:43 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id b88so38826677edf.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 15:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BpKe/Gzzoypttoufc83q6ut7PE+9y8+V3o63c5S4Wxw=;
 b=FVRPktb9XKheNHV2iJqYF7oILNe3KtMe4oPZPgU8OUVz9iZPQ5v21BCRnr39zF3KYy
 C2mpKLlIreY4E69PmZGJWvkNjrCDRVhy4m7Du/jlpmQW078oYuUWyFn7ZPxi4p/9wLC7
 5nar0LjGKk2mkCbDLx2ne4dqLH8vQXbzTRPZROwIaV+bGunHDbReDHCYq7015+0ZVltp
 bQ8P+KK8JHH+H/Su7WAk3cLsTRnCGVoR3RD03Cmj/LcnITvJws729ED6QuEptXOVKnzF
 K2KEO12lc+RCc3DKt6z5Pcnu80W4fvbys2B0ok28pf57XsXCyzgUCBEEN6hx7c6Pa1dP
 fw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BpKe/Gzzoypttoufc83q6ut7PE+9y8+V3o63c5S4Wxw=;
 b=pmkP3kSa/YhTzM0OfqaFQhjXBJGxsFtY0PvRa4o5zZhvhzFg7GiHA9PEd7G0p7E6k1
 gTmvZyeGmDpPZbICM587lqxpVu7fJnYLLjJTdTANfKk0VaWdaWcbmC+5GW8hnFnj2MJQ
 CxU+IM39GFUS7PF5CfVw7+kYZb3hqb69ngtYFsBmOwFZIYwYniGLv5QaF4tI5Cxo1P8o
 T/On6GVoXvodEcQfQd6Z7QjJHulhnZlW5xRuUWzcCPEAzX5qV8kfCrTmXC0rb4fABFMg
 3xhHaazvHhuYndDYuF5H2OWdsh1SkToNifFWQCDRC5TGeCXRFjT2GrcF8FfXRe71nqXI
 X8Ag==
X-Gm-Message-State: AFqh2koUjN7CKjfD1ADZtIm0OUWShZUE94p0oEuwqlBKdIZF9IZLMrR0
 VEE/IXEpjhNMeD8j54Pz5ejFNZ6yqKNQ1putdYGEntfs
X-Google-Smtp-Source: AMrXdXubAiiTFuwHJRK5s8QH6/n067xrNp3PbgHVMeooNDmuy71KA6ZpFWoEmb/rMMGylr9zZcr+LtfEqF2yYBtX39k=
X-Received: by 2002:a50:cc47:0:b0:461:b6a9:c5cb with SMTP id
 n7-20020a50cc47000000b00461b6a9c5cbmr5130647edi.148.1672787321719; Tue, 03
 Jan 2023 15:08:41 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
 <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
 <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
In-Reply-To: <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 3 Jan 2023 18:08:05 -0500
Message-ID: <CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000018905305f164262e"
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

--00000000000018905305f164262e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see about the access now, but did you even look at the patch? Because
what the patch does isn't even exposed to common drm code, such as the
preferred domain and visible VRAM placement, so it can't be in fdinfo right
now.

Or do you even know what fdinfo contains? Because it contains nothing
useful. It only has VRAM and GTT usage, which we already have in the INFO
ioctl, so it has nothing that we need. We mainly need the eviction
information and visible VRAM information now. Everything else is a bonus.

Also, it's undesirable to open and parse a text file if we can just call an
ioctl.

So do you want me to move it into amdgpu_vm.c? Because you could have just
said: Let's move it into amdgpu_vm.c. :)

Thanks,
Marek

On Tue, Jan 3, 2023 at 3:33 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Take a look at /proc/self/fdinfo/$fd.
>
> The Intel guys made that vendor agnostic and are using it within their IG=
T
> gpu top tool.
>
> Christian.
>
> Am 02.01.23 um 18:57 schrieb Marek Ol=C5=A1=C3=A1k:
>
> What are you talking about? Is fdinfo in sysfs? Userspace drivers can't
> access sysfs.
>
> Marek
>
> On Mon, Jan 2, 2023, 10:56 Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Well first of all don't mess with the VM internals outside of the VM cod=
e.
>>
>> Then why would we want to expose this through the IOCTL interface? We
>> already have this in the fdinfo.
>>
>> Christian.
>>
>> Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> To give userspace a detailed view about its GPU memory usage and
>> evictions.
>> This will help performance investigations.
>>
>> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>>
>> The patch is attached.
>>
>> Marek
>>
>>
>>
>

--00000000000018905305f164262e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I see about the access now, but did you even look at =
the patch? Because what the patch does isn&#39;t even exposed to common drm=
 code, such as the preferred domain and visible VRAM placement, so it can&#=
39;t be in fdinfo right now.<br></div><div><br></div><div>Or do you even kn=
ow what fdinfo contains? Because it contains nothing useful. It only has VR=
AM and GTT usage, which we already have in the INFO ioctl, so it has nothin=
g that we need. We mainly need the eviction information and visible VRAM in=
formation now. Everything else is a bonus.<br></div><div><div><br></div><di=
v>Also, it&#39;s undesirable to open and parse a text file if we can just c=
all an ioctl.</div><div><br></div><div>So do you want me to move it into am=
dgpu_vm.c? Because you could have just said: Let&#39;s move it into amdgpu_=
vm.c. :)<br></div><div><br></div><div>Thanks,<br></div><div>Marek<br></div>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Tue, Jan 3, 2023 at 3:33 AM Christian K=C3=B6nig &lt;<a href=3D"ma=
ilto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzume=
rken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
 =20
   =20
 =20
  <div>
    Take a look at /proc/self/fdinfo/$fd.<br>
    <br>
    The Intel guys made that vendor agnostic and are using it within
    their IGT gpu top tool.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 02.01.23 um 18:57 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">What are=C2=A0you talking about? Is fdinfo in sysfs=
?
        Userspace drivers can&#39;t access sysfs.
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 2, 2023, 10:56
          Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken=
@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Well first of all don&#39;t mess with the VM internals
            outside of the VM code.<br>
            <br>
            Then why would we want to expose this through the IOCTL
            interface? We already have this in the fdinfo.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">To give userspace a detailed view about its
                GPU memory usage and evictions.<br>
                This will help performance investigations.<br>
                <br>
                <div>Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"ma=
ilto:marek.olsak@amd.com" rel=3D"noreferrer" target=3D"_blank">marek.olsak@=
amd.com</a>&gt;</div>
                <div><br>
                </div>
                <div>The patch is attached.</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--00000000000018905305f164262e--
