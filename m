Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7061C3DA7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 17:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBD310E1BA;
	Mon,  2 Jan 2023 17:55:51 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB1D10E1BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 17:55:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id jo4so68126000ejb.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jan 2023 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbqJ6xsGqranUq0k2YkAijMf0mAZgeKJ/7NLA3iDSNI=;
 b=VUt7XJNvsCxEe/bG5IP0YLAHpNY/mjuJlWS9oppQSPZXN6hBZDawPQgA81taBV1RC9
 V8QgYbFu/Ood53UJCzLGwTAPG4w6X6WF+WYwrnjN3ldRkwh2tiErnI3cZhqJZEwljRHR
 AeOtUAGbtYdcA9uDfdSxbuHFGeI8wnnXxviRL9oxk0t3OxWq0nPi2nRvCFKJIgp8mbkC
 YWBkIuheoOaEINPn9mM+AaulTsHfRZnT8fUAMVOeokuK8ljCdPfiLL3U6M0QH3bZK975
 D4+6Nm5joinCAcsq/LC7XCi32K/Sb/2TOEqFrFBf9oQz76+pJiWh3yyeZpVeVHMOtoFF
 55+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbqJ6xsGqranUq0k2YkAijMf0mAZgeKJ/7NLA3iDSNI=;
 b=lubyyJe1O9QjGIu10EJQLk4lYXgstrv6HsIuN4+fR6+PTTgExZoM3DF0hyAw4Pv3jy
 1sPAjKGp9ykb90B1/4+qrzMHD9cgiT8cqh+uvSAuL7xl90vkJ5daNcBBwvBdnGmUQqCk
 apTXgvqbmpTsUccchnfvLX9wf6dFgChwEvgVBbgDF8WiPU6A2sBX7XFNCVODJtpH7U9N
 +cB6EaQr4FGvh3VNbk2l0FdoGtjRIKVU7prNXHiNsgsXVjA+fZqgeKlT+GBZrmCLXtQN
 oZF3wvD4Lyv7EtWyEqEw6AoVvxidvIeuyJ1eviDLk10ft+exAU2TlqrIpRq20hGedg+0
 ug8w==
X-Gm-Message-State: AFqh2kqQf3Smz5VneltP9wvQWUz40RwgXnM5j+EjBhQpsWAAelppU+at
 NVMsgbDNyC1wnEUNtCwqtXbIiAxygAUMM9/TnDc=
X-Google-Smtp-Source: AMrXdXt0zqEmXe9N05fa2VA7XoFo+z0pTA3Ndc5nr4yrPPQ9A94zJ4F9k6KZ5v4XexYQNUNED+Ataw8EYBlXbGtSIYk=
X-Received: by 2002:a17:906:d973:b0:7ad:d411:30af with SMTP id
 rp19-20020a170906d97300b007add41130afmr2423650ejb.636.1672682148066; Mon, 02
 Jan 2023 09:55:48 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
In-Reply-To: <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 2 Jan 2023 12:55:35 -0500
Message-ID: <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000041f91705f14ba909"
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

--00000000000041f91705f14ba909
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Userspace drivers can't access sysfs.

Marek

On Mon, Jan 2, 2023, 10:54 Christian K=C3=B6nig <ckoenig.leichtzumerken@gma=
il.com>
wrote:

> That stuff is already available as current_link_speed and
> current_link_width in sysfs.
>
> I'm a bit reluctant duplicating this information in the IOCTL interface.
>
> Christian.
>
> Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:
>
> For computing PCIe bandwidth in userspace and troubleshooting PCIe
> bandwidth issues.
>
> For example, my Navi21 has been limited to PCIe gen 1 and this is
> the first time I noticed it after 2 years.
>
> Note that this intentionally fills a hole and padding
> in drm_amdgpu_info_device.
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> The patch is attached.
>
> Marek
>
>
>

--00000000000041f91705f14ba909
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Userspace drivers can&#39;t access sysfs.<div dir=3D"auto=
"><br></div><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 2, 2023, 10:54 Christi=
an K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoen=
ig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
 =20
   =20
 =20
  <div>
    That stuff is already available as current_link_speed and
    current_link_width in sysfs.<br>
    <br>
    I&#39;m a bit reluctant duplicating this information in the IOCTL
    interface.<br>
    <br>
    Christian. <br>
    <br>
    <div>Am 30.12.22 um 23:07 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">For computing PCIe bandwidth in userspace and
        troubleshooting PCIe<br>
        bandwidth issues.<br>
        <br>
        For example, my Navi21 has been limited to PCIe gen 1 and this
        is<br>
        the first time I noticed it after 2 years.<br>
        <br>
        Note that this intentionally fills a hole and padding<br>
        in drm_amdgpu_info_device.<br>
        <br>
        <div>Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:mar=
ek.olsak@amd.com" target=3D"_blank" rel=3D"noreferrer">marek.olsak@amd.com<=
/a>&gt;</div>
        <div><br>
        </div>
        <div>The patch is attached.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--00000000000041f91705f14ba909--
