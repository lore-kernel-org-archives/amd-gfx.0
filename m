Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43090C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 18:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E5B10E923;
	Thu,  1 Aug 2024 18:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PcBjlQcn";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F76A10E923
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 18:56:11 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so9857891a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Aug 2024 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722538569; x=1723143369; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OeVxN+jLKyRxR/zA0QhowN0zawlkYe7ReP65bYd5H3A=;
 b=PcBjlQcnotIpVPLvHZuGTMH0xVNGZJjOlyKJ+0BAnU2SXBbDa/L7kKVfFP4Na6QhIP
 pPiGmOMBZ8iktLfa1Y/52sTc5FoBJ8VxFc+W3YYPLqHWBkZimxGB4jnuo0lf7rKmU0NE
 XyEMeRg+RAfqUPnEYKnB2lhG6s93lsEGqZxTHJS2LCLYpkNniQ7XofF+hFkm5U7LW421
 QGH4P+DgDqTnmLqTyMG/vu2YCxLazhHWJeimC9BttajdzoayNDFUwJcHHV/UVGDUA8hv
 4YNjJWyC2IcCsYLU4iW51gr4NmhT2pWkA6e8YD5JD4oqNOVvlPEHx+o9vcrqH7Fs7v+2
 f6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722538569; x=1723143369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OeVxN+jLKyRxR/zA0QhowN0zawlkYe7ReP65bYd5H3A=;
 b=X4DTpIG7q8WHVhRtN9LkOlVVA4e/ixmP5zE7W20Nm8NhseAsOaodu18EPCzAOLVSzH
 5D7Ez9FHzUykpFHxVCu54rdE4zfvK+PgDe5ybBTpdX9njKnArtgbfbjGys7thhyzmMCq
 DjfIUM0DdHYthOVWaUnyAd6guFldyzGOIFOrvB8K4yXqknN5V/ixZd+AUlmjBGNHu4fe
 yndUhXFr8DBsyPkXHN5vryyDGSEM6bhRWPcahp5kJim4kTrc5KOXt9mtcuKeOGmtK7kz
 7iyucVhYri2jt7nCoExsVaS5b7uJdGOjIjlX1ZWNPpne9l5TQUYethoDjAPqruWDqJKH
 zlpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXn6Kl8AfaHO4p1MtJ5yATe6Z0J5eoewS0j/DUj+JeJtBkUPxHmyizUJHHzua/xPNur2xsgBt6tP2fPA6pFNk6pujDHc5UJMkaEcsk7g==
X-Gm-Message-State: AOJu0YyyYhqAPsrl+bOqcRK8TVfWgiAI4UBtxjI9UiLXZhnuHjzaEb7l
 WxAVPu08ckdeKxgYqGgwNHnIO0M045mySdILYZqCZLDu7ILnLWACU51ajUFx42srx8FsGtYS3bE
 T0JZ0v1hoLH4sqNcimOIeR73cASpFcw==
X-Google-Smtp-Source: AGHT+IG6X7oGIvcdHupft+LV7B1GwpcA1hOSJG+PxhIdzKbcq4zLvEfZ3KgJoCJeg4ac2MJhpZjlmZCh5667t2mvNAg=
X-Received: by 2002:a17:906:c115:b0:a7d:9f92:9107 with SMTP id
 a640c23a62f3a-a7dc51bdf6cmr73937366b.58.1722538569178; Thu, 01 Aug 2024
 11:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
 <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
In-Reply-To: <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 1 Aug 2024 14:55:56 -0400
Message-ID: <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
Content-Type: multipart/alternative; boundary="000000000000872928061ea3c37f"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000872928061ea3c37f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024, 03:37 Christian K=C3=B6nig <christian.koenig@amd.com> =
wrote:

> Am 01.08.24 um 08:53 schrieb Marek Ol=C5=A1=C3=A1k:
>
> On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com> wrote:
>
>>
>> On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:
>> >> +       /* Header is at index 0, followed by num_nops - 1 NOP packet'=
s
>> */
>> >> +       for (i =3D 1; i < num_nop; i++)
>> >> +               amdgpu_ring_write(ring, ring->funcs->nop);
>> > This loop should be removed. It's unnecessary CPU overhead and we
>> > should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
>> > whole packet body uninitialized is the fastest option.
>> That was the original intent to just move the WPTR for the no of nops
>> and tried too. Based on Christian inputs we should not let the nops pack=
et
>>
>> as garbage or whatever was there originally as a threat/safety measure.
>
>
> It doesn't help safety. It can only be read by the GPU with kernel-level
> permissions.
>
> Initializing the packet body is useless and adds CPU overhead, especially
> with the 256 NOPs or so that we use for no reason.
>
>
> Not filling the remaining ring buffers with NOPs is a pretty clear NAK
> from my side. Leaving garbage in the ring buffer is not even remotely
> defensive.
>

What are you defending against? You know the ring is kernel-owned memory,
right?

Marek


> What we can do is to optimize filling N DWs into the ring buffer without
> updating the WPTR each time.
>
> Regards,
> Christian.
>
>
> Marek
>
>

--000000000000872928061ea3c37f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, Aug 1, 2024, 03:37 Christian K=C3=B6nig &lt;<a href=3D=
"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><u></u>

 =20
  <div>
    Am 01.08.24 um 08:53 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 1, 2024, 00:2=
8
              Khatri, Sunil &lt;<a href=3D"mailto:sukhatri@amd.com" target=
=3D"_blank" rel=3D"noreferrer">sukhatri@amd.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><br>
              On 8/1/2024 8:49 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
              &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Header is at index 0,=
 followed by
              num_nops - 1 NOP packet&#39;s */<br>
              &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 1; i &lt; num=
_nop; i++)<br>
              &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0amdgpu_ring_write(ring,
              ring-&gt;funcs-&gt;nop);<br>
              &gt; This loop should be removed. It&#39;s unnecessary CPU
              overhead and we<br>
              &gt; should never get more than 0x3fff NOPs (maybe use
              BUG_ON). Leaving the<br>
              &gt; whole packet body uninitialized is the fastest
              option.<br>
              That was the original intent to just move the WPTR for the
              no of nops <br>
              and tried too. Based on Christian inputs we should not let
              the nops packet<br>
              <br>
              as garbage or whatever was there originally as a
              threat/safety measure.</blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">It doesn&#39;t help safety. It can only be read b=
y
          the GPU with kernel-level permissions.</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Initializing the packet body is useless and adds
          CPU overhead, especially with the 256 NOPs or so that we use
          for no reason.</div>
      </div>
    </blockquote>
    <br>
    Not filling the remaining ring buffers with NOPs is a pretty clear
    NAK from my side. Leaving garbage in the ring buffer is not even
    remotely defensive.<br></div></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">What are you defending against? You know the r=
ing is kernel-owned memory, right?=C2=A0</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>
    <br>
    What we can do is to optimize filling N DWs into the ring buffer
    without updating the WPTR each time.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
        <br>
      </div>
    </blockquote>
  </div>

</blockquote></div></div></div>

--000000000000872928061ea3c37f--
