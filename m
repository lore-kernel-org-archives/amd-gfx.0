Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1677DFA1FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 20:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C87710EA52;
	Wed, 22 Apr 2026 20:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9eMqFFD";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6ADF10EA54
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 20:54:45 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso317243c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 13:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776891285; cv=none;
 d=google.com; s=arc-20240605;
 b=MZTKFeiRzGorFHNQ1qn5YSsSRT/gJN3yCUJPwowSOZOXAPcS23r+6Uz07ZCL2ecmCz
 PtAVDV4s64P26p8AH5PXnkPt/ZI+Q0TU2oEF5MS8L560yZUVqBOOtw4Z/U3mfvOAw+X9
 nciXDQarVVg4nGQX4IpkpF23QnO3WpACGCY7NeKkFozqC/9MStQy9nz3GOiOZ17BalZ+
 iyJxXLR5Ix5YLaP2oTEFocE4rYmq/hBaTqFEO3fTknWPwx08WBnMjfBtfJnUQW8KJko3
 d6yvK2Wk3cHsMmLUGG0/8k6bwcUMJ3tJtsrKxFpXwToTr32FrVmEoi4sZ/8x1D1nLypU
 ruYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9/vSojQ0MIlLdTKErdaVMimElKfxbQl7mzkFfT1rIj8=;
 fh=doiAuR+3WY+XOSJ7fxVEB0AzUibKc9aIaPKZanfPh88=;
 b=feKCBrG2avINwSNfy2NpfDdQQnPTJijRCBVfUnHfAZbul8nMEhC0oB5Ku7aZ7FdV0Q
 5HnTjNVxj8b0Ny/m2k2mkSdfBd2Ot+IneQ0GSI9y6cqXME/GUen0MUM8oxqM/A7nk/qQ
 o0qw2hyTeitRzn0Own3LkHoko/L8L6eDZaLAF0AaajR0+zbm6W0SjlPCKFE5Dl5D6GWF
 JP+AL27Edz3NGHcM1YLnXkW3X+DucAsBBqYgP5oexu2wexk9xEehTbziZNMy+h16bALq
 pT30JU6FenLpiS6sJSSoEtbYCMLogzWIMZzxvTX+bACnpt2gcfb5VoHt0dzdkC0C6tFy
 rWWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776891285; x=1777496085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/vSojQ0MIlLdTKErdaVMimElKfxbQl7mzkFfT1rIj8=;
 b=Z9eMqFFDgI9FzPKQXh23Vaemmd87qutOxWeaC+UKuuRvBMCa/tvIUNxccuWkPTN2gu
 HcMRpVL8SmCqHc4/mTcS17M43rUiV2VP6NjT3ygHQlIY3RWhjjWLsLT4oXeszGv4Xs3Z
 gb5Ky3sNFzacA2G9A2NYXAA13n4ydSJzI4NxBXEHldMwGnnYRIWFJtcLTCnezI7+F7lv
 Wa+fuorO9UU9nNdzgAKcHmME935lIQmp8zEWs6dv/lcbpp3WXKTjtTE3GcmlIQDBrwJZ
 GgeNFyUlE35MXPoIs3hu09b+8f0JNfTYHDJWL2O58hwilhTE2Ry/YoNsjez6dlGoP6KM
 1cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776891285; x=1777496085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9/vSojQ0MIlLdTKErdaVMimElKfxbQl7mzkFfT1rIj8=;
 b=BkdK4VdC0gfFaqtMj4+uhcMDw3dat9mOcGODHmQ9QTCT9r0fZ4uUiJVc15RxOIqrMM
 uBRHUpzbOukwqxsTAqhHUS6JwYPYHEjSqcy1mHv0e+5BxV7xMV09n34BpRLK0ZW4Uh/G
 0jBkO1L+xlZDODQadzH7o9f1KtlkNOq3FucMBkFVWTYtikv4BNyp0qTYXUBoTcxwj8Wf
 4Q9CXjsu48YPDqJc06HAyZfVy4Inia8W0oOWcNCblsqtNlG6loUy8rrtQm+S8N0Vdh7F
 sPrsagZei6h2LvdgpQaB0CBuA66hr9hwsmkqAaIdOAdhlWVPK0yT1RI7gSga5MpVq0Ji
 6BoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Lp32ODk+HPFkrRIjjjGtwJe9aFAzHXmdcC8dYT9sCixSSLZUd7jAwuoqqsdCDNz1eXWN0ckOu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxggxQV3V20dI4jAZl0k2E690QzC+VNQgXwG6c2Ajdjdr9ePG6u
 z7itqH2tcOq9JY45VUChrqj7LO/DuEBGfc6lY1E85xsVuiGed3fKnKnX58WGfALrg2sYMOOhrem
 aAsXeeyjSJFjR5lbrASoZEV7lkV/746o=
X-Gm-Gg: AeBDietIIyrZ9QUuQpSTi1sd3m3G9ww7prhbQgDzW4gMUx2oTGHxvf1efFDLqC3FUW9
 qU0TUI1qFIATkMQX2WvmwmMHaf7MTbzqnWVS+YSIpk3PL1aPphSzrnCeX0AeWDTeHVQxRU/wRmY
 cViYrKqQgSeTdWEZlBxPh7TxCrlRYZDNgY3MzOPRdLRNIr14TJZtmypC7AU1oPqnw93UHpEbMGI
 nEmgriuorjefcb1QCvQ/U43iG79/TOGZnQooDPgckn6hR6SUp7Rsct+i/D+LQnkId5cmxxY7r/U
 p25iBe10JMbV3Mt/3foS0ob/47691/uX8IrjAdNPpaWXQAntyDnPa/29LYCeeI6W3jJAUoZRuzk
 IL4crGP1EIdo9Xns=
X-Received: by 2002:a05:7022:b94:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-12c888baed5mr3761042c88.1.1776891284830; Wed, 22 Apr 2026
 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260421132303.GCaed6N9mDwutP6sEx@fat_crate.local>
 <CADnq5_POMAQyY1OtqE6v4-NwoN2ViUCTeq-RQp79UwpMeDZRYA@mail.gmail.com>
 <20260422203314.GCaekwikuCiHx8CK-S@fat_crate.local>
In-Reply-To: <20260422203314.GCaekwikuCiHx8CK-S@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 16:54:32 -0400
X-Gm-Features: AQROBzDPSGTMSo9mTABgs9UFcUZoFXPWDgchm7qsWhjnLAqqV3nYhfRa9VmG0pQ
Message-ID: <CADnq5_MD=88gWXFp_-sQ0qpj-xDbqNsEkofnaNqFkQbJL43hNg@mail.gmail.com>
Subject: Re: amdgpu: WARNING:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58
 at dc_assert_fp_enabled+0x10/0x20 [amdgpu], CPU#5: (udev-worker)/418
To: Borislav Petkov <bp@alien8.de>
Cc: Rafal Ostrowski <rostrows@amd.com>, amd-gfx@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 22, 2026 at 4:33=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Apr 21, 2026 at 10:06:01AM -0400, Alex Deucher wrote:
> > On Tue, Apr 21, 2026 at 9:59=E2=80=AFAM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > Hi,
> > >
> > > this is latest Linus from today on a Zen2 laptop:
> >
> > +Rafal Ostrowski
> >
> > I think this should be fixed by:
> > https://patchwork.freedesktop.org/patch/718415/
> > Which is already included in my last PR.
>
> So I just tested:
>
> Merge: d46dd0d88341 a7756371e57f
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Apr 21 17:39:21 2026 -0700
>
>     Merge tag 'drm-next-2026-04-22' of https://gitlab.freedesktop.org/drm=
/kernel
>
> hoping that your fix might've landed in the meantime there but nope, it s=
till
> fires.
>
> Also, patchwork is timeouting for me so can you pls send me this patch in=
line
> here so that I can run it?

It's in drm-next, should land in this week's next-fixes PR.
https://gitlab.freedesktop.org/drm/kernel/-/commit/07598c76964a2c73702fa652=
bcd07ec21088c5ef

Alex

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
