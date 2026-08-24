Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50485C61DC2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 13:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCF110EA4D;
	Tue, 25 Aug 2026 13:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tFyrfcud";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989FA10E158
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 16:12:26 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-97c367c9f12so706247241.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 09:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787587945; cv=none;
 d=google.com; s=arc-20260327;
 b=qPlOsugDTH98N8uxC7eEAoceCfKP38vy2ztLcWmiIeAqhDsFAtfyReLWb/rAMZhNhs
 4lg+AxYUAGEdjYcc4FqZQDdT1PoCoMi/BBHyPPAEnzl2geT0Ak9WOTIGzQGf9IUG4BLI
 mOJjFUINvIuT81Ty+kIQTl+iBEsPSvDdio5OZ84c8x02N5zWSDiq7e0QHy9moE3TyW79
 VkyoSgFNxMmlV4iVb2n6cZgCmJfQ5WcQ0pGjLzUSHC830FIQkLV0FwuL8A6PiP4wlwgy
 qRbZgywZgk0yP7qXDR+Nx33JZJouTmRt4qpUFqd5GoNtx6301lrTB8XZMi6yvd4nkpgR
 LQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O5GnI96d1qijyPnPxxxKVYgXnMY884SeT2oB81A5aAA=;
 fh=XWndytK1AXNvQHbQqkNJk0zut13GhNr5NTBq+ckZAx4=;
 b=jWOpmhkCMVSl6uaHx5QkSwzUUmKkgv3Vnhjl0/i/Zkld56cQCm78YE+Ya/w3s0Qy4c
 BCwkYWLaesMiPasAFTOZSx+Iw72PjHFrlzwRhJWBIhahXCP9V2YAFGMkLDvQQfTCRcDp
 ii80xeCuaYkm/gwNhViS6+Ial+YHJyzGBPE0sjQ1pO7+X2s8jcEHyBwhdR7c68vMwDje
 tlizd6JTOb4b35qKeYa1Mz/gisXWXgUIH7Wh8JGCcOvmyn5pAPT2ABxHyP6a/T3lMwVj
 52r9l0ylqA1r8ErkwJh/+IUHLFqSZKTu9PWnx8RM05lb53mDwMvpD3TdwTW8eKHaAJbn
 4U6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787587945; x=1788192745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O5GnI96d1qijyPnPxxxKVYgXnMY884SeT2oB81A5aAA=;
 b=tFyrfcudEd3zD3toIdOvQg1y2PRRDCwomGOs59lqt3zU5jW6qvtFX1yTdQ8gmtYELh
 4CU1nAwBcT/PCopBaC+lbzFKulsmKBn/OQOJZ2VRvUw8a0QhPj9SMMJG9H63Wb6xqrH2
 bYv7dDwRQr4PN9fLSnk5pwFLh7ntqnyGOohl2TiRK6L9dH14OBI1eSExoOE03wprIL3t
 Oy6kjyKM3BSALInV4x6Qa7AT3bMSsM0uTrD2h8+Kpf6hwKwvyWYbvzkkfn8hRUFkIB0p
 aN2V8p8U7ExjJ2IeIPm+qgBUwKduL/XeM7BGbnabNLc8iX4r4M+zNrk1AZdgP9kiodsG
 1ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587945; x=1788192745;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O5GnI96d1qijyPnPxxxKVYgXnMY884SeT2oB81A5aAA=;
 b=dW1y7BMb6MtZJw8jl5Nz6Z6JHjLFuk/FwfwXTiUZpppc8I0bOm1Z1Y0nyQ666KMss5
 A2kIrrulKI9IlnIALEpLGQcWcAJBUlJi1BEktZAZfw8TtOYxFOkT0ckFfhmVblZCkDyy
 lsk5Z9f848kbTb8gF+O8UBPDb+sPDNAmfgB6K4DCaRtOfiAd6y4ZKPO04dn07LVYCbs8
 IBprmNnmhed5hVN06LkzS1n6JTBnriGNqGM9eTqdF0NVooHxJIB0tU8NBKLzBfjdX1e+
 p9NGtQN2m5T/afJ6i2AXnFiRwatxY56bzBSe6dWl7oSrPNVz3d2/iYSoig4lHuDMLqoY
 NXCA==
X-Gm-Message-State: AFuF++mJfBnYsJFSOa+KvSk7Kp3Qni3rXnJtWLej3pi7iXNyUIjdxZQU
 mazmr6b34a6iirHhU+XU/oFBkQI3cv7x4cV2Pw5utCc+KFqx5naW8kr99g1n6sKLyRMRdW0DX2j
 1Gl8gfyBI7yTlJ25gHT6l6EB+UlqaFA==
X-Gm-Gg: AR+sD11eda4ng4lYiIOzHbSWuC/QDWE31VPqa0u2ot+FXFL/bAHkOrZziFOnRctTqAf
 2EswEfV4MRCDKVYTE1DKBlG9lx/i7c3gfmQVecivblB0C5iSd3loRQfVJ8/WoRJu9AEtfSUYRR9
 6vRG34G834TUJ+4SOWh0p1gFan6C7IlG4QGKrWxAqp+8LMOrM5+ZHrXLFkBxO0CCynxyJEHR40d
 nRhTKKEvvxJvxfW+7DHNK2jHOJ7o65RYH9FLqHlcI+gPnkNJsLVumlXLFUsa2GwqFVCWzJCD9kA
 0+EJ9Qpvf7ipBIyx7CulA6ayYIj0wUJR+p92yvtwqEdKu0aYdiBBGg==
X-Received: by 2002:a05:6102:f12:b0:77b:54f9:7713 with SMTP id
 ada2fe7eead31-77b54f988acmr6381591137.7.1787587945139; Mon, 24 Aug 2026
 09:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260824144714.182835-1-upcfrost@gmail.com>
 <GoS-FsT8QACGf_8gWuUlnQ@gmail.com>
In-Reply-To: <GoS-FsT8QACGf_8gWuUlnQ@gmail.com>
From: Petr Belyaev <upcfrost@gmail.com>
Date: Mon, 24 Aug 2026 18:11:48 +0200
X-Gm-Features: AcwNN1Vo8lMfh8JWfdrnofmMIRAeZH5hC4umrRrCvaJtayr5IuuYkxj2rPWDX0Y
Message-ID: <CAKzDyZvprPt9QmsDuuqVcvisz1KLKMfmWQrpMtcUWnXeOn8MEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/smu7: Don't send VddC_Request on CI
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Aug 2026 13:01:27 +0000
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

Hi,

You're right, and I withdraw the patch - hadn't considered that gating
it off would regress the systems it was added for.
Apologies also for the M380 claim; I thought it was VI from the commit
message rather than checking.

To reproduce:
Stock 6.18.41, Bonaire XTX 1002:6658 rev 00 (XFX 1682:7260), VBIOS
113-260XT-HY12832-D5-2G-10, SMC firmware 11.35.0 from bonaire_smc.bin.
DC is not enabled here (amdgpu.dc left at the default).
I'm getting roughly 40 "failed to send message 15f ret is 0" messages
per boot, ~1.9s each.
gitlab: https://gitlab.freedesktop.org/drm/amd/-/work_items/5678

One more observation: Your MCLK DPM quirk does fire on this card - i
see the msg 'disabling MCLK DPM on quirky ASIC' in dmesg.

Would be happy to test anything that might solve the problem.

Best regards,
Petr


On Mon, Aug 24, 2026 at 5:07=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Monday, August 24, 2026 4:47:14=E2=80=AFPM Central European Summer Tim=
e Petr
> Belyaev wrote:
> > smu7_upload_dpm_level_enable_mask() calls
> > smu7_apply_minimum_dce_voltage_request() unconditionally, which sends
> > PPSMC_MSG_VddC_Request to the SMC. CI SMC firmware does not implement
> > that message: it is only defined in smu7_ppsmc.h, tonga_ppsmc.h and
> > fiji_ppsmc.h, and there is no CI equivalent. The SMC therefore never
> > writes SMC_RESP, PHM_WAIT_FIELD_UNEQUAL() spins until it gives up, and
> > every call burns the full ~1.9s response timeout.
>
> Hi,
>
> I'm sorry but this is wrong.
> I added the VDDC request specifically to solve an issue with a Bonaire GP=
U.
> That system will boot into a black screen without requesting a high enoug=
h
> voltage for the display engine. This patch would regress that.
>
> >
> > Nothing downstream notices, because ci_send_msg_to_smc() returns 0
> > regardless of the outcome. The only effects are the delay and
> >
> >   amdgpu: failed to send message 15f ret is 0
> >
> > in dmesg. On a Radeon R7 260X (BONAIRE, 1002:6658) this is 40 messages
> > per boot: 32 during the boot-time modeset, which becomes ~59s of blank
> > screen, and 8 more on every DPMS wake, adding ~15s before the display
> > comes back.
>
> How do you reproduce this issue, and on which kernel version?
> I've tested this patch on two different Bonaire chips and a Hawaii chip, =
and
> haven't seen this error message. In fact I am running an R9 390X right no=
w and
> I don't see this error message in my logs.
>
> >
> > Commit 0138610c1413 ("drm/amd/pm/smu7: Fix SMU7 voltage dependency on
> > display clock") extended this feature to CI, which the previous
> > implementation had deliberately excluded -- the old call site was
> > guarded by pp_table_version =3D=3D PP_TABLE_V1 with an adjacent comment
> > reading "TO DO for v0 iceland and Ci". That commit was verified on a
> > Radeon R9 M380, which is VI, so the CI path went untested.
>
> The CI path definitely did not go untested.
> R9 M380 is Bonaire (it's in an old iMac).
> You can see all the details here:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/3425#note_3338643
>
> Best regards,
> Timur
>
>
