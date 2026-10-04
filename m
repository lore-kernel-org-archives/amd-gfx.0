Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA8BCA6005
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F97010EBD6;
	Mon,  5 Oct 2026 07:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p2lnEFrf";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D60A10E4A4
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2026 05:56:49 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so158549766b.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 22:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791093408; cv=none;
 d=google.com; s=arc-20260327;
 b=szyKOJ+J0S4ENR/GbIeLeNQBo2HCZv+5c16JzLu6C6zK8tMcrz+V+y0hda86bWVmTo
 7YaFX92hNhgbVk9gW1LruiSB0+swLjlfYcobhDmV6o13cnpbRHd+TrfONwq/OdAa0tkM
 T3Mmw3LeZGPnEcYDZ0P6Xn/MyDPR1fFx6Wc5TJO4FjTd8TE2mWFSrHmyCWD/Xg+rVNS7
 C7AagMvhYh9Be3PUAwxAIa53sX7WqeA3y8z5fbd4+ZSi1y9VUgXdR+Mj9XefR0SVVHGF
 meVtSOUsg/8H3pcQmYC4EF5e3C5CGrfYQjmVctUgDxA7U3R4h8sS2Q7k+NOfHAQiURTD
 jNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LMdNbjTdi5xzByl3Yr/DVC/9gi+Pezxmg0NW3tAphHM=;
 fh=dWPoB/3Br0VksMTTnGSgUwTj94SWsKhOQ0TEoBzTNBU=;
 b=XI2PcRRUS2vpgMeSSm4giACFhJbFOOOF90SUXU9LnwVPcRxaTUqAQktD4OpWCeBt3l
 qrM9K8oGGYXPTuINeZvMGGbgLaZCGkmzSB/VIZh1iC31M09L4OAsceCVEM77D0Emys0A
 BXv53N07XYuh834QkfkRDObc0lhEMWeMOn1PWSOL1LBld+WJpNcs+RkNNDB9cHin/8sL
 26XnO+y0yz/LCJ9XRpQDd6kROc+TM2d8l1ezpr1Mce8Mf+zaiQryneqVJoxyO2vJzX8n
 gMAwTcitWToMgTN5g8BXqfiDXo/isqwUGpi3i1IN+FeCV2q726GpPC779s1jR2VXhDDN
 BXMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791093408; x=1791698208; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LMdNbjTdi5xzByl3Yr/DVC/9gi+Pezxmg0NW3tAphHM=;
 b=p2lnEFrf+iHZf703HhSiYO6BpGUVBjxWvWJy9AyATz8VwX7k5nbRg+NBdEZiN2IICA
 /GDLjvu0Dz9IHhfAGmJuHonkS/m/GGzl3Fe7flxuRQmJ7Jk9cQuHOglNWcdlx8rzRRFu
 85Su2Y9z/oBZThsF7J2FD29+QoPhnNEJqjaTR+WIIGaWOqVXYHALlK4KxPeFi/ryoagu
 GjK1wuc80Ab/0J0ZDWc/UCFjihpobjtYvGRxiHV3qcfyTX5ZBP5gMIJh455NeFPu7dln
 tZd6xqMYJzxWl6PwFaiMklsGXjw5ejgKRZYT75YpW/UO+NoknZ8fmDgKhtxPKVXG2Fwo
 ZyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791093408; x=1791698208;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LMdNbjTdi5xzByl3Yr/DVC/9gi+Pezxmg0NW3tAphHM=;
 b=bE7a5+UxyU77mfFdqLc1bH8xrdHknYWsf8/WOZvSppKN9Ib2yXwPeKx3StdLnVEmRD
 P3bsAZAg6dUzFHJR93F6+T48f3piUWy576vZXkyQynTqgJhfvfMCg4TfCaFdyCHI+jqo
 RiZ2MCdGoZ81h3vRVi5XawQNZQEdMkeXu7pu5bJwJwNOlmCkCR+bMNiJC/7t0Dgroa9f
 jvaPOIKy5flk+XgVGlaLxBm8aWL5j8eLFRvXdu7JMUXbphfS9FUJYkVVcMuxIlqBFEZ9
 Rdjquhe1a/RolEaN592W47kQKjYsrXk2MJZGfOqWyXtu9W17cjHZQe1cdbeEWetNZo7W
 6GAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmfKeT8RnpmzOsW+PwJ0dr4t6llFI1U9Da9yoUZajkOhw7xqRk09vqXd2+dqLQH4P8rsvxmOJk@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNJsSCzetKzDwIjD/KVUeLCG/D9FsLRJ74oECPhE1teIj+u1z8
 yqZkqeWZvpUTp9PILGWxQhXZJsKKtgi+XQv/EJgUW0MoTU4KMUKeoFyMSDrNhUivehLbeILf3a8
 n7C8QhuyvlkXglR9f2RSONl3epLhXc0w=
X-Gm-Gg: AYBFou0muOesbkmoFFQBdGvhohEPQxw2NikhRssD36um7xMgtZ8u/dzX6GpPOxj27aM
 h0qUbz/3ib0UEDRGYhD/vKWDIB7qNBz01Qw0DyyUX9iaiJLbDESZbA/FUTDnlS2UtZKVwuO3n+H
 Px5O/Ny88ZjTd0QpEgMO/rL+TCr+WDSfAwYb/nrhHV5Ldvz2bssd57xMVUq7C+xuV7UVoTtsGK9
 3mVFpCH6Z4BdwIKOpDa7wvSHe+DBAi9tCKB0o0DPkMhxP2zETxQbw+/28ClK+JV9H3U/KjlBPQz
 BYLrCDC3DpdIyzNgnEETBJVpo1WfycbFxgojour2FXr1aDBh7FMljg==
X-Received: by 2002:a17:907:96aa:b0:c2e:3d17:5259 with SMTP id
 a640c23a62f3a-c2e6ee1df6emr328319766b.41.1791093408045; Sat, 03 Oct 2026
 22:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072444.18982-1-ayhancicek@gmail.com>
 <CADnq5_PWzO-UqBJgduTy-X7bYnxSJyBZxL0TcsBue3S9cWyTUw@mail.gmail.com>
 <CAL556cf0rbxePZ9m-W81SOx+aX27Csc6x52QYdJypoX1pJQcsw@mail.gmail.com>
In-Reply-To: <CAL556cf0rbxePZ9m-W81SOx+aX27Csc6x52QYdJypoX1pJQcsw@mail.gmail.com>
From: =?UTF-8?B?QXloYW4gw4dpY2Vr?= <ayhancicek@gmail.com>
Date: Sun, 4 Oct 2026 08:56:36 +0300
X-Gm-Features: AclHuK8_p_i8K0raFZJ_C1DkTmqdNHoAVP46Ee6Q_RDueJhQThA6Rg8WdkJz7eA
Message-ID: <CAL556ccbh2w-dyoxodM+CAnVoL3er=HpR79_jzdQgjAHgVimPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: extend MacBook VRAM-at-0 workaround to VERDE
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch
Content-Type: multipart/alternative; boundary="000000000000589c98065cfd6e67"
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

--000000000000589c98065cfd6e67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delayed response. I wasn=E2=80=99t able to test the patch
immediately because I had surgery, so it took me a little longer than
expected to get back to this. Thank you for your
patience.

I tested the generic patch on the affected MacBookPro11,5 with a
Radeon R9 M370X (VERDE).

The test was performed with the hardware cursor enabled and without
the Mutter software-cursor workaround.
Before and after repeated cursor movement, the kernel log remained at
zero occurrences of:
DC: Cursor address is 0!
DC failed to set cursor attributes

I also did not observe any cursor disappearance, flickering, or
instability during testing.

The generic patch appears to fix the issue on this hardware.
Tested-by: Ayhan =C3=87i=C3=A7ek ayhancicek@gmail.com


Thanks,
Ayhan


26 Eyl 2026 Cmt 01:24 tarihinde Ayhan =C3=87icek <ayhancicek@gmail.com> =C5=
=9Funu
yazd=C4=B1:

> Thanks, that approach makes sense and looks cleaner than handling
> individual ASICs.
> I'll test the attached generic patch on the affected MacBookPro11,5 with
> the Radeon R9 M370X (VERDE), with the hardware cursor enabled.
> I'll verify that the original symptoms do not return and that the kernel
> no longer reports:
> DC: Cursor address is 0!
> DC failed to set cursor attributes
> I'll report back with the test results and add my Tested-by if everything
> works as expected.
> Thanks,
> Ayhan
>
>
> Alex Deucher <alexdeucher@gmail.com>, 25 Eyl 2026 Cum, 16:19 tarihinde
> =C5=9Funu yazd=C4=B1:
>
>> On Fri, Sep 25, 2026 at 3:46=E2=80=AFAM Ayhan =C3=87i=C3=A7ek <ayhancice=
k@gmail.com> wrote:
>> >
>> > The existing MacBook workaround reserves VRAM at address 0 for
>> > Polaris ASICs when the iGPU is enabled. This prevents cursor
>> > allocations from landing at address 0.
>> >
>> > A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same
>> > failure mode. Hardware cursor updates repeatedly log
>> > "DC: Cursor address is 0!" followed by
>> > "DC failed to set cursor attributes".
>> >
>> > Extend the existing workaround to CHIP_VERDE. With this change,
>> > hardware cursor operation is stable, the cursor errors remain at
>> > zero during repeated cursor movement, and cursor disappearance
>> > and flicker are no longer observed.
>>
>> Sounds like this may be consistent for most or all Macs.  How about
>> something like the attached patch?
>>
>> Alex
>>
>> >
>> > Signed-off-by: Ayhan =C3=87i=C3=A7ek <ayhancicek@gmail.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > index 1bf2a42fa..9e7f9cc2b 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> > @@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct
>> amdgpu_device *adev)
>> >         case CHIP_RENOIR:
>> >                 adev->mman.keep_stolen_vga_memory =3D true;
>> >                 break;
>> > +       case CHIP_VERDE:
>> >         case CHIP_POLARIS10:
>> >         case CHIP_POLARIS11:
>> >         case CHIP_POLARIS12:
>> > --
>> > 2.55.0
>> >
>>
>
>
> --
>
>
> Ayhan =C3=87=C4=B0=C3=87EK
> Software Architect
>
> +90 532 291 21 62
> http://www.ayhancicek.com
>
>
>

--000000000000589c98065cfd6e67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Apologies=C2=A0for=C2=A0the=C2=A0delayed=C2=A0respon=
se.=C2=A0I=C2=A0wasn=E2=80=99t=C2=A0able=C2=A0to=C2=A0test=C2=A0the=C2=A0pa=
tch=C2=A0immediately=C2=A0because=C2=A0I=C2=A0had=C2=A0surgery,=C2=A0so=C2=
=A0it=C2=A0took=C2=A0me=C2=A0a=C2=A0little=C2=A0longer=C2=A0than=C2=A0expec=
ted=C2=A0to=C2=A0get=C2=A0back=C2=A0to=C2=A0this.=C2=A0Thank=C2=A0you=C2=A0=
for=C2=A0your patience.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I=C2=A0tested=C2=A0the=C2=A0generic=C2=A0patch=C2=A0on=C2=A0the=C2=A0affect=
ed=C2=A0MacBookPro11,5=C2=A0with=C2=A0a=C2=A0Radeon=C2=A0R9=C2=A0M370X=C2=
=A0(VERDE).</div><div dir=3D"auto"><br></div><div dir=3D"auto">The=C2=A0tes=
t=C2=A0was=C2=A0performed=C2=A0with=C2=A0the=C2=A0hardware=C2=A0cursor=C2=
=A0enabled=C2=A0and=C2=A0without=C2=A0the=C2=A0Mutter=C2=A0software-cursor=
=C2=A0workaround.</div><div dir=3D"auto">Before=C2=A0and=C2=A0after=C2=A0re=
peated=C2=A0cursor=C2=A0movement,=C2=A0the=C2=A0kernel=C2=A0log=C2=A0remain=
ed=C2=A0at=C2=A0zero=C2=A0occurrences=C2=A0of:</div><div dir=3D"auto">DC:=
=C2=A0Cursor=C2=A0address=C2=A0is=C2=A00!</div><div dir=3D"auto">DC=C2=A0fa=
iled=C2=A0to=C2=A0set=C2=A0cursor=C2=A0attributes</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">I=C2=A0also=C2=A0did=C2=A0not=C2=A0observe=C2=A0a=
ny=C2=A0cursor=C2=A0disappearance,=C2=A0flickering,=C2=A0or=C2=A0instabilit=
y=C2=A0during=C2=A0testing.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">The=C2=A0generic=C2=A0patch=C2=A0appears=C2=A0to=C2=A0fix=C2=A0the=C2=
=A0issue=C2=A0on=C2=A0this=C2=A0hardware.</div><div dir=3D"auto">Tested-by:=
=C2=A0Ayhan=C2=A0=C3=87i=C3=A7ek=C2=A0<a href=3D"mailto:ayhancicek@gmail.co=
m">ayhancicek@gmail.com</a></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Ayhan</div><=
div><br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">26 Eyl 2026 Cmt 01:24 tarihinde Ayhan =
=C3=87icek &lt;<a href=3D"mailto:ayhancicek@gmail.com">ayhancicek@gmail.com=
</a>&gt; =C5=9Funu yazd=C4=B1:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 dir=3D"ltr"><div dir=3D"ltr">Thanks, that approach makes sense and looks c=
leaner than handling individual ASICs.<br>I&#39;ll test the attached generi=
c patch on the affected MacBookPro11,5 with the Radeon R9 M370X (VERDE), wi=
th the hardware cursor enabled.<br>I&#39;ll verify that the original sympto=
ms do not return and that the kernel no longer reports:<br>DC: Cursor addre=
ss is 0!<br>DC failed to set cursor attributes<br>I&#39;ll report back with=
 the test results and add my Tested-by if everything works as expected.<br>=
Thanks,<br>Ayhan</div><div dir=3D"ltr"><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">Alex Deucher &lt;<a href=3D"mail=
to:alexdeucher@gmail.com" target=3D"_blank" rel=3D"noreferrer">alexdeucher@=
gmail.com</a>&gt;, 25 Eyl 2026 Cum, 16:19 tarihinde =C5=9Funu yazd=C4=B1:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Sep 25, 2=
026 at 3:46=E2=80=AFAM Ayhan =C3=87i=C3=A7ek &lt;<a href=3D"mailto:ayhancic=
ek@gmail.com" target=3D"_blank" rel=3D"noreferrer">ayhancicek@gmail.com</a>=
&gt; wrote:<br>
&gt;<br>
&gt; The existing MacBook workaround reserves VRAM at address 0 for<br>
&gt; Polaris ASICs when the iGPU is enabled. This prevents cursor<br>
&gt; allocations from landing at address 0.<br>
&gt;<br>
&gt; A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same<br>
&gt; failure mode. Hardware cursor updates repeatedly log<br>
&gt; &quot;DC: Cursor address is 0!&quot; followed by<br>
&gt; &quot;DC failed to set cursor attributes&quot;.<br>
&gt;<br>
&gt; Extend the existing workaround to CHIP_VERDE. With this change,<br>
&gt; hardware cursor operation is stable, the cursor errors remain at<br>
&gt; zero during repeated cursor movement, and cursor disappearance<br>
&gt; and flicker are no longer observed.<br>
<br>
Sounds like this may be consistent for most or all Macs.=C2=A0 How about<br=
>
something like the attached patch?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Signed-off-by: Ayhan =C3=87i=C3=A7ek &lt;<a href=3D"mailto:ayhancicek@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">ayhancicek@gmail.com</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 1bf2a42fa..9e7f9cc2b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct amd=
gpu_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_RENOIR:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;=
mman.keep_stolen_vga_memory =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_VERDE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS10:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS11:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_POLARIS12:<br>
&gt; --<br>
&gt; 2.55.0<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><br><div><font size=3D"2"><br><font face=3D"verd=
ana, sans-serif" color=3D"#444444">Ayhan =C3=87=C4=B0=C3=87EK<br>Software A=
rchitect</font></font><div><font color=3D"#444444" face=3D"verdana, sans-se=
rif" size=3D"2"><br></font><div><font face=3D"verdana, sans-serif" color=3D=
"#444444" size=3D"2">+90 532 291 21 62</font><div><div><font face=3D"verdan=
a, sans-serif" color=3D"#444444" size=3D"2"><a href=3D"http://www.ayhancice=
k.com/" target=3D"_blank" rel=3D"noreferrer">http://www.ayhancicek.com</a><=
/font></div><div><br></div><div><br></div></div></div></div></div></div></d=
iv></div>
</blockquote></div>

--000000000000589c98065cfd6e67--
