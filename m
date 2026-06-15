Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D536CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C11110E030;
	Tue, 16 Jun 2026 12:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SsKljXJr";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1027B10E42B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 13:33:45 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso6536847a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 06:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781530423; cv=none;
 d=google.com; s=arc-20240605;
 b=Bc9s55HwZrSWH2oJz8gPhVkIrZrGxp58Vhcp10un1GdJsdpJHIurOplcT0vK4Vlixg
 N2fuzGAekcNmrGedH+5hT/gKLULhKpnqbSkS+q6Sr4sdJr8U1njqa4X4B2qBicmJIz1X
 PMb/AoGaMsGWBUVkiYscqlHur0+0dIIZ7kDEL0UAk+NOo2yNOFCmED2Bx69qqKKy4bg1
 fKEkvFdEgf6knrVzZAFxOjajybnG4amInHpHh3ZmXiiKxGGXSdBUd6I5P4qGEJa8KOix
 CvvbtNdfIp+6aSsY5Oy4TUIyzrLFQ6uL50pJzj2dRXRUDmFBj5TGOflqPl2aqtmEGb89
 vkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hIpLTQp8c/NSnuk0PoBcY1wUcRDkSj3E+f8vFJi+pa0=;
 fh=KF+1tpWp/GK4GYhmaS/K0pmpHo1wv48nDWT+vrx0R98=;
 b=YWjo5mdzs9Cif0JherrbcxE2twDyrfgd/DbCXqOkePD/uiE+fqii5rfcKmSri5oIST
 B2iwgdNbjT2cFQmt+RtwRPEodqBATMy0J9h7PPeCqeOgdopjoFN1Vjyeuo6cDw8/svqb
 JJvfdNxNiMgIfK0hRCYNC6E+HjXjYsMgnU5ebmEfIibSUPWL6B/4XX3QzeSKnWvVgdmk
 5H20MhNQnt4+A9fgeD6oSyJgSN9eMFE08/YDXcWBmdpe+J2GkQLzl0C7Fv4gDa98SgXu
 bcERRYDhJkmyjZHQFeHDTptUForPPFALcJtViHkW3TQdp0wYSqYdBrS2eP7CgeReP9Kx
 vD8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781530423; x=1782135223; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hIpLTQp8c/NSnuk0PoBcY1wUcRDkSj3E+f8vFJi+pa0=;
 b=SsKljXJrGckjZJfd0m+mIOz8ac9iDyGTEp923F/LiIdgPPP7HTkZtwMcWNe53mg9/w
 tBOOIR7sag9lEf0QfJw8DY4w1NtmRQWyz2pHNu/aHUluCL5Y7PXO8+iSi3KCkckckBD8
 JwMxQttpdcI47DnLVTYHhJtiPxxqIkUaTSkV4ift621t8p/lOeCX57qwmU7CIl5N/78I
 XWyTbsRtCfbSB+VTbviKO3y6HbvRk3v6cm0rRkXZ4Dl894cLlsod6ViYXqsapE6eSQpO
 OcIUsDHFiHAchJcz1n37TYV0zQ7J+INmcjoHQQYVQZkEft7q7NdsWAtM883lQc7YRa1V
 9Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781530423; x=1782135223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIpLTQp8c/NSnuk0PoBcY1wUcRDkSj3E+f8vFJi+pa0=;
 b=VRh/HuCiPZ4F/7QQyCknY0+y6i/n9khBlaSFKT6t4uPNLfH9ZKVhLPGgpOOl8lFg2+
 kHsFn2Rk7sYfiOTBtRBQR6ioKPUtSw3NF/PP3R/f5SGkQDDvDm3w+TCJhoM7fEWqbCd1
 aBHj5KSBLGVDtY+BhUTkkBi0qhE942958zYmDtSOO/pqDn9Cv7hasgh7VU+4iI7pw0ZU
 mZmWXE4+dj61SjwqpRoe9nqHtKkH4RB6J174G1JnGhAjVSLbu+4y3w5V5JXhGy7cAzAa
 yuHOvr97pMhl+eNO0DJuqXKlFGUagO6b6AAsv1eYrAfVJcbuHG0DepVXMOPGblQ58h1W
 9Clg==
X-Forwarded-Encrypted: i=1;
 AFNElJ91a3NfHf6d0OvYvfA+GmZmAFnGdeIW2grtvEOrVpSdCOpJQTjRtvX1oigCb6BmErqxXJlZAqk0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBZbRuy0OUEK/doqwmIlqsn24F64FyXNkfWfh5NnhsBto23MpE
 Mylpy3DUSlMyRBKwhaOSyM1oOYAQBrxhvcTfmE3yZTHtFqC8C/J9H4CjZaCcOq12rHf5EW0orVB
 79NjfPFt+vXmWvxo7XiiL6cmqpwfZ+2Q=
X-Gm-Gg: Acq92OHs3ecE2zc0Yudf8crppvkaRcZY84C7lh4fwCpiEuC0JQYuIjNYLQzZqF/8bCq
 Hb3OUv4DniRi9vLSLkfe+j1sA5SRSlegYyIeCrcVJP0WwEXIrDXN7pueZTB9kFEQynLfX5JL3m7
 7gQCIXoBAcBoP/MfQIGWmBcalBrs7dE38SYMbfqgkuBXLly6utxRztDVkl8d+76FQ14p9tailc/
 2cgmE7ceU2qHeoP2cwF7Z68PTcZHmeJtnN8BlgJxd1DsFH/aTopEwitdkLtFYB38Arm4cMnyNG1
 RbtuFjBpiGpfawGbKB9luaNBd9kRw2Iw8BI1B4NyxyKLLzb44HS74BF/95RkUM0w1sSuxA==
X-Received: by 2002:a05:6402:a54e:20b0:67c:34bb:1bd1 with SMTP id
 4fb4d7f45d1cf-6936833fa9fmr4116863a12.1.1781530423302; Mon, 15 Jun 2026
 06:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPs_=oyWXJuQ4VS7LNQgM=jGKPMDoj1OnagU9YNQY+7aEeabHw@mail.gmail.com>
 <4898269.vXUDI8C0e8@timur-hyperion>
 <bf77a811-bce8-4257-b3bf-207c3a01a44e@amd.com>
In-Reply-To: <bf77a811-bce8-4257-b3bf-207c3a01a44e@amd.com>
From: "Jonathan L." <jonaphin@gmail.com>
Date: Mon, 15 Jun 2026 09:33:17 -0400
X-Gm-Features: AVVi8CfuS64dLUKCOzDmSG_gJFFuqxU0yfd8jPHI70m1fDagSkICaLI744Sn1OU
Message-ID: <CAPs_=oxcHA8zRWBpZOn3Nq_pJajePtrzpYkYTxaQmjroCjbjRg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Linux_7=2E1=2Drc7_regression_=E2=80=94_ROCm_GPU_memory_ops?=
 =?UTF-8?Q?_hang_on_Strix_Halo_=28gfx1151=29?=
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Harish.Kasiviswanathan@amd.com
Content-Type: multipart/alternative; boundary="000000000000099d0806544ae042"
X-Mailman-Approved-At: Tue, 16 Jun 2026 12:49:33 +0000
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

--000000000000099d0806544ae042
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi team,

Thank you for the prompt replies.

Christian, I have tested the amd-staging-drm-next branch, and ComfyUI is
now working as expected. I did encounter an error when setting
AMD_SERIALIZE_KERNEL=3D3, as it appears only 0 and 1 are supported, but thi=
s
seems unrelated to the primary issue.

Thank you all for the excellent work!

Best regards,
Jonathan Lancar


On Mon, Jun 15, 2026 at 8:39=E2=80=AFAM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

>
>
> On 6/15/26 14:01, Timur Krist=C3=B3f wrote:
> > On Friday, June 12, 2026 3:12:29=E2=80=AFPM Central European Summer Tim=
e
> Jonathan L.
> > wrote:
> >> Hi team,
> >>
> >> I am reporting a regression in the AMDGPU driver affecting the Strix
> Halo
> >> APU (Radeon 8060S, gfx1151). While everything works correctly on kerne=
l
> >> 7.1.0-rc5, upgrading to 7.1.0-rc7 causes GPU memory operations to hang
> >> indefinitely. This occurs during tasks like torch.empty() or model
> weight
> >> transfers in ComfyUI (PyTorch 2.11.0+rocm7.13).
> >>
> >> I have bisected the changes in drivers/gpu/drm/amd/ between rc5 and rc=
7
> and
> >> identified the following potential causes:
> >
> > Hi Jonathan,
> >
> > Can you please bisect which of those four patches causes your issue?
> >
> > Thanks,
> > Timur
> >
> >>
> >> 1.  amdgpu_hmm.c (Christian K=C3=B6nig):
> >>
> >>   - 1c824497d: Changing the invalidate callback to wait on the VM root
> BO
> >> reservation lock may be introducing a deadlock.
>
> No, that was done before anyway. Just with a different BO.
>
> >>   - 962d684b5: Moving the notifier_seq read outside the retry loop cou=
ld
> >> cause infinite retries with a stale sequence number.
>
> That was indeed an issue but should be fixed on amd-staging-drm-next. Can
> you re-test with that branch?
>
> Thanks,
> Christian.
>
>
> >>   - 58bafc666: Changes to userptr submission waiting.
> >>
> >> 2.  gfxhub_v12_0.c (Timur Krist=C3=B3f):
> >>
> >>   - 40bab7c60: The change to CRASH_ON_*_FAULT bits might be causing th=
e
> GPU
> >> to retry failed memory accesses indefinitely rather than surfacing a
> fault.
> >
> > Your Strix Halo chip has a GFX11.5 core which uses gfxhub_v11_5.c
> > Changes to gfxhub_v12_0.c will not affect your chip.
> >
> > Note that retry faults are not enabled on Strix Halo by default, and
> don't
> > behave the way you described.
> >
> >>
> >> 3.  gmc_v12_0.c (Harish Kasiviswanathan):
> >>
> >>   - ae4e30f24 and e3fa02872: If the new per-version PTE address masks
> for
> >> gfx1151 are incorrect, it could result in corrupted page table entries=
.
> >>
> >> 4.  amdgpu_gart.c (Donet Tom):
> >>
> >>   - ec4c462e2: The updated PTE iteration grouping may be producing
> >> incorrect page tables when combined with the new PTE mask.
> >>
> >> Downgrading to 7.1.0-rc5 resolves the issue. Please let me know if you
> >> require any specific debug output or further testing.
> >>
> >> Best regards,
> >> Jonathan
> >
> >
> >
>
>

--000000000000099d0806544ae042
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi team,<br><br>Thank you for the prompt replies.<br><br>C=
hristian, I have tested the amd-staging-drm-next branch, and ComfyUI is now=
 working as expected. I did encounter an error when setting AMD_SERIALIZE_K=
ERNEL=3D3, as it appears only 0 and 1 are supported, but this seems unrelat=
ed to the primary issue.<div><br></div><div>Thank you all for the excellent=
 work!<br><br>Best regards,<br>Jonathan Lancar<br><br></div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Jun 15, 2026 at 8:39=E2=80=AFAM Christian K=C3=B6nig &lt;<a =
href=3D"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 6/15/26 14:01, Timur Krist=C3=B3f wrote:<br>
&gt; On Friday, June 12, 2026 3:12:29=E2=80=AFPM Central European Summer Ti=
me Jonathan L. <br>
&gt; wrote:<br>
&gt;&gt; Hi team,<br>
&gt;&gt;<br>
&gt;&gt; I am reporting a regression in the AMDGPU driver affecting the Str=
ix Halo<br>
&gt;&gt; APU (Radeon 8060S, gfx1151). While everything works correctly on k=
ernel<br>
&gt;&gt; 7.1.0-rc5, upgrading to 7.1.0-rc7 causes GPU memory operations to =
hang<br>
&gt;&gt; indefinitely. This occurs during tasks like torch.empty() or model=
 weight<br>
&gt;&gt; transfers in ComfyUI (PyTorch 2.11.0+rocm7.13).<br>
&gt;&gt;<br>
&gt;&gt; I have bisected the changes in drivers/gpu/drm/amd/ between rc5 an=
d rc7 and<br>
&gt;&gt; identified the following potential causes:<br>
&gt; <br>
&gt; Hi Jonathan,<br>
&gt; <br>
&gt; Can you please bisect which of those four patches causes your issue?<b=
r>
&gt; <br>
&gt; Thanks,<br>
&gt; Timur<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; 1.=C2=A0 amdgpu_hmm.c (Christian K=C3=B6nig):<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- 1c824497d: Changing the invalidate callback to wait =
on the VM root BO<br>
&gt;&gt; reservation lock may be introducing a deadlock.<br>
<br>
No, that was done before anyway. Just with a different BO.<br>
<br>
&gt;&gt;=C2=A0 =C2=A0- 962d684b5: Moving the notifier_seq read outside the =
retry loop could<br>
&gt;&gt; cause infinite retries with a stale sequence number.<br>
<br>
That was indeed an issue but should be fixed on amd-staging-drm-next. Can y=
ou re-test with that branch?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
<br>
&gt;&gt;=C2=A0 =C2=A0- 58bafc666: Changes to userptr submission waiting.<br=
>
&gt;&gt;<br>
&gt;&gt; 2.=C2=A0 gfxhub_v12_0.c (Timur Krist=C3=B3f):<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- 40bab7c60: The change to CRASH_ON_*_FAULT bits might=
 be causing the GPU<br>
&gt;&gt; to retry failed memory accesses indefinitely rather than surfacing=
 a fault.<br>
&gt; <br>
&gt; Your Strix Halo chip has a GFX11.5 core which uses gfxhub_v11_5.c<br>
&gt; Changes to gfxhub_v12_0.c will not affect your chip.<br>
&gt; <br>
&gt; Note that retry faults are not enabled on Strix Halo by default, and d=
on&#39;t <br>
&gt; behave the way you described.<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; 3.=C2=A0 gmc_v12_0.c (Harish Kasiviswanathan):<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- ae4e30f24 and e3fa02872: If the new per-version PTE =
address masks for<br>
&gt;&gt; gfx1151 are incorrect, it could result in corrupted page table ent=
ries.<br>
&gt;&gt;<br>
&gt;&gt; 4.=C2=A0 amdgpu_gart.c (Donet Tom):<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- ec4c462e2: The updated PTE iteration grouping may be=
 producing<br>
&gt;&gt; incorrect page tables when combined with the new PTE mask.<br>
&gt;&gt;<br>
&gt;&gt; Downgrading to 7.1.0-rc5 resolves the issue. Please let me know if=
 you<br>
&gt;&gt; require any specific debug output or further testing.<br>
&gt;&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt; Jonathan<br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div>

--000000000000099d0806544ae042--
