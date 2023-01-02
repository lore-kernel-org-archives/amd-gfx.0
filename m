Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBBAC3DA7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 17:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4B910E1BF;
	Mon,  2 Jan 2023 17:57:27 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518F610E1BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 17:57:25 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id qk9so68103435ejc.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jan 2023 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35eOASSBwYJrOIjmXkkOcDuahKm7/bsXatq6iYQbFlM=;
 b=Yzw3A5Bvb8NJJ4h1p+4R2fw+vvqzK3oHpBib6mTH+3RCToLE1GZL68p/OoyYGLEdFj
 QcEujXctERDkgSA2n6mPFBOpZqCclfvefVgoQiN6UcMfqYE2KgEqQF9Ne9PW/kW9LLLR
 zqPJISOmMs6mE+CsH/hOFgWJr7/sLX9CwyaPqSByVEE5g8RLWCRSG4b4epYmKCu6MOrC
 i4fGdgfsmzv5N56CSoj2VBgQ/MJ3tFqPonPotj7GrWWcpOoXFx0InKre1+8xBkeeIUsC
 lO7lCG2bYwUAMcn+pU0xPFajOpKJ3EaJ5gUZ8BtRompm51h1fhNTCWabb1ROMXwwQbWT
 LlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35eOASSBwYJrOIjmXkkOcDuahKm7/bsXatq6iYQbFlM=;
 b=mrjErIzBRsfuM9tEtIimu6CjtDiWjX1I9JeYrLikk8Na5hObOtV49iVYcILofU410p
 CLC2VvB7KSGptmaerVYf8ckQ5VrJYg+D/3KG3mI9C3TDQP6wNKhLfa7ifgqquTnApXuj
 m12Ooj/apVMmbO+xY6JId80Gq0WuRpGGF0NcFcA8UxQScvrN3ynnnz92HKy0bVnd6+dD
 tjmjQ+z1PDFszLHgaE/L7nCrOSyKzO2Fi/feBdo5OZWJ5cQBvm+bA8sseWm8v9Pz6lAx
 0VpKjH/0tVlWRi+N3Mnpzn1OasZdGBXVpe1zRxQnYm52Q+g8t6FadC4IzgMjFnlQqELG
 nYcg==
X-Gm-Message-State: AFqh2koB7r0Un4e8UmG8NkJIa8xtxzKxnL+djjWcRvu/MgsWfqk/Drxs
 rjv9NUIyOW7mO7LgqlRZwOuoKdyQ1nwva49xzQa9bNEu
X-Google-Smtp-Source: AMrXdXsCCBh1IUCr76ENX5T7P/8nnqsWDoG+Q10QvtQqZ/mFSHt1YtvU01j9/clvTVWdShH5BA6mlbhUZ1KDNKqSIas=
X-Received: by 2002:a17:906:1407:b0:7c1:7226:c935 with SMTP id
 p7-20020a170906140700b007c17226c935mr4789739ejc.338.1672682243780; Mon, 02
 Jan 2023 09:57:23 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
In-Reply-To: <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 2 Jan 2023 12:57:11 -0500
Message-ID: <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f674d805f14bae52"
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

--000000000000f674d805f14bae52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What are you talking about? Is fdinfo in sysfs? Userspace drivers can't
access sysfs.

Marek

On Mon, Jan 2, 2023, 10:56 Christian K=C3=B6nig <ckoenig.leichtzumerken@gma=
il.com>
wrote:

> Well first of all don't mess with the VM internals outside of the VM code=
.
>
> Then why would we want to expose this through the IOCTL interface? We
> already have this in the fdinfo.
>
> Christian.
>
> Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:
>
> To give userspace a detailed view about its GPU memory usage and eviction=
s.
> This will help performance investigations.
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> The patch is attached.
>
> Marek
>
>
>

--000000000000f674d805f14bae52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">What are=C2=A0you talking about? Is fdinfo in sysfs? User=
space drivers can&#39;t access sysfs.<div dir=3D"auto"><br></div><div dir=
=3D"auto">Marek</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Jan 2, 2023, 10:56 Christian K=C3=B6nig &lt;<a=
 href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div>
    Well first of all don&#39;t mess with the VM internals outside of the V=
M
    code.<br>
    <br>
    Then why would we want to expose this through the IOCTL interface?
    We already have this in the fdinfo.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 30.12.22 um 23:07 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">To give userspace a detailed view about its GPU
        memory usage and evictions.<br>
        This will help performance investigations.<br>
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
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000f674d805f14bae52--
