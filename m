Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A59C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 16:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C840810E8AC;
	Thu,  9 Mar 2023 16:03:09 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DA910E85C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 16:03:00 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id a25so9156216edb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 08:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678377779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mdEmtA8he8XpAXQxD7Oi8AM18R2IReI3en5GolDw6EU=;
 b=QauhhKaVIW9t7lmcxez9SRdoAAz3M3afKfU97OVXVfzmtwCEOQ5TwvvsFuTOx7jCY+
 +L3MCMEP2Ppq4/JB/iqioHnNzpiARw9pjkus4VJi/FTbyQleD5X179Xkz7xVkSWQhEnM
 ZiC5qdoPQ1R+ZB9uRM0Qb0y5ZG4eVF6vbfOacRBdQzeylM4SwEaJYsmDGgVuaqI3K4Uc
 HHK658+YnKJFR1981pqVoBlO4gHcFEoqtep/mmE7kYnsM7fl0ctcoTM2qLBGUH6PR1FI
 uX++xWw1D4gmNv26WmQV20bZZyXMo9Xw+iZOZXcRNdaWn7NEu9Dwm5W+baxcJ72JAK/0
 OqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678377779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdEmtA8he8XpAXQxD7Oi8AM18R2IReI3en5GolDw6EU=;
 b=F1zCojaJoD+YNKHvf7eFTioDqXtoHVcMzYYzZO9as+Bv0et2rSgXrCwGriNDWigsNM
 xctqYo5eX/sFIurmDwcU9oBjt8pc/rDI4cPYkEKL1zOp7CD8FTm5LSULadroutPMTdp1
 NPfhvwxwgODxq29L5RmG5gIJeqh0CLTMQ/HYyASHEswbvSKJPL6Y4SmSVMNM4UA1IYsi
 sKULPs+LV20c5jQhsSWbjPLQp6WqDljK+TGac/JiBrFoSXfHvLqq2qUdDXqXhSbYBXYa
 32/Ymibp8tXCb/YmGyG0UD5K/xLnMmkwNhF3hJrSUzQWh76tOUiqsJLtfkre+pdnpHnj
 m4Jg==
X-Gm-Message-State: AO0yUKVL/LDUWlZp7w6eQXn7WYRUcyxYkgmVz3kmvsuMtTnpwREWut1C
 xev9KMZZN1hQ/8TVIE8x6m8JxKCx3NtK6TOY3Yo=
X-Google-Smtp-Source: AK7set8Xrv5l0ijV5HSphfoIeeTLx0EKpXrx6jE79rg3NK4pjLdLWiaQpMT0I3se2QhL2r8khjemPSWSlkNWvCvsc1Q=
X-Received: by 2002:a17:906:3503:b0:8ab:2b8b:143d with SMTP id
 r3-20020a170906350300b008ab2b8b143dmr11418019eja.7.1678377778933; Thu, 09 Mar
 2023 08:02:58 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A6Y=++EP8vqzqjGQ3kfh2=JC7PKGoyJvfw9pFVL2UcNJg@mail.gmail.com>
 <3c2f16a9-64f2-9124-afc4-43af37fb82fa@gmail.com>
 <CAAxE2A54Z_ghZFFBb+s-0kx4z-st=XyLXb1fVHkfw2z=ROTC-A@mail.gmail.com>
In-Reply-To: <CAAxE2A54Z_ghZFFBb+s-0kx4z-st=XyLXb1fVHkfw2z=ROTC-A@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 9 Mar 2023 11:02:22 -0500
Message-ID: <CAAxE2A6uh5z0i=g1yFXid509Mo0OkJJ-2N_23wqfn2XTRJAr5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: expose more memory stats in fdinfo
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004ff38505f679c704"
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

--0000000000004ff38505f679c704
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Thu, Feb 23, 2023 at 1:46=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:

> Updated patch attached.
>
> Marek
>
> On Mon, Feb 6, 2023 at 4:05 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Just two nit picks:
>>
>> +    seq_printf(m, "drm-evicted-visible-vram:\t%llu KiB\n",
>> +           stats.evicted_visible_vram/1024UL);
>>
>> For the values not standardized for all DRM drivers we might want to use
>> amd as prefix here instead of drm.
>>
>> +    uint64_t requested_gtt;        /* how much userspace asked for */
>>
>> We used to have automated checkers complaining about comments after
>> members.
>>
>> Kerneldoc complicent comments look like this:
>>
>>                  /* @timestamp replaced by @rcu on dma_fence_release() *=
/
>>                  struct rcu_head rcu;
>>
>> Apart from that looks good to me.
>>
>> Regards,
>> Christian.
>>
>> Am 30.01.23 um 07:56 schrieb Marek Ol=C5=A1=C3=A1k:
>> > Hi,
>> >
>> > This will be used for performance investigations. The patch is attache=
d.
>> >
>> > Thanks,
>> > Marek
>>
>>

--0000000000004ff38505f679c704
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping<br></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Feb 23, 2023 at 1:46=E2=80=AFPM Marek Ol=
=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div>Updated patch attached.</div><div><br></div><div>Marek<br>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Feb 6, 2023 at 4:05 AM Christian K=C3=B6nig &lt;<a href=3D"ma=
ilto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzume=
rken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Just two nit picks:<br>
<br>
+=C2=A0=C2=A0=C2=A0 seq_printf(m, &quot;drm-evicted-visible-vram:\t%llu KiB=
\n&quot;,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 stats.evicted_visible_v=
ram/1024UL);<br>
<br>
For the values not standardized for all DRM drivers we might want to use <b=
r>
amd as prefix here instead of drm.<br>
<br>
+=C2=A0=C2=A0 =C2=A0uint64_t requested_gtt;=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0/* how much userspace asked for */<br>
<br>
We used to have automated checkers complaining about comments after members=
.<br>
<br>
Kerneldoc complicent comments look like this:<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* @timestamp replaced by @rcu on dma_fence_release()=
 */<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct rcu_head rcu;<br>
<br>
Apart from that looks good to me.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 30.01.23 um 07:56 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt; Hi,<br>
&gt;<br>
&gt; This will be used for performance investigations. The patch is attache=
d.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Marek<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000004ff38505f679c704--
