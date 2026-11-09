Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07F606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FqynElP6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DB110E245;
	Mon,  9 Nov 2026 14:05:34 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20AC10F34A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 14:05:27 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-990bc7aed3dso23252241.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 06:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794233126; cv=none;
 d=google.com; s=arc-20260327;
 b=aqHBTPcUVQc/Ubfinq+WIfgmfDSUVl1PB3CR/80XygLWoT/MRwXfsbOWBLCkBbj5dV
 NdkRDClfumW9uvh2BTNfbO1UmyRm+Q0gALqAI41zrB6bgnzHFS0amEMxdqOrRcKZ3BXg
 XIirc73kmnsnd98q5QG50GjmNUN4AcUDyNyDV/t3e4lCVa7B7vPTEWkQsX6kr0QEAZQW
 LbMm0RWVdW4d2MwdVnVFjm1KeokaHxBRDgxosCWFmgcbx9Nl/8/JIKnpyD7VDOGMeQdf
 8d+JZhb8ruBpdXvcXQggFa+BLvInWs3nDFlydpIvAk/1pknU4fON8JGbGpN3PXbJ6U7m
 /bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hBMYWxF4MCqpQhvGes4d8FlHIJELgoUuQCBw2En9gT0=;
 fh=d2OTX2cBE+gTrSV3qfu+b5FYjRz9/jvSDPTvKVf5wew=;
 b=CBk01IWKYbiL7UIhxaravgBa0EkQNGm4LFz4rZ1gY2kUOJN09vk1ukgJf6cLf6DAxs
 MdXx8OA6a+43MGCT1n6wqEysfQalMgOEdJLKzs5c/gndgQ9i31lVVbw4J6kpZQKZ8pJo
 2VRxGbMDp+cIJkTDzQc0I5Uo63IdMskz0soHTlq/LK15Es3sMLZW/8D+zTbvrtepCmN9
 7CrFXdhFzhqA2SVBKyrjRg0L2/Ndly7UiXAiKsZGHqQEap0aRTYT05nHgX3gvs0vbkLa
 R59vGiYYhy0GFxu8383m9wlsZVUj2UaqmIEtIh6oDOGvfWOR/irK9NPDf8HrKHBUGvqu
 WXwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794233126; x=1794837926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hBMYWxF4MCqpQhvGes4d8FlHIJELgoUuQCBw2En9gT0=;
 b=FqynElP6u44OeWmZehPL0nISjm6qwTocJbumASHWxyVVanp93htMaYZ4dsjOKWIRgJ
 WmuRjj0DcCv+PhUHtpsmPm+vJwLs2oq1Wyq0ixfwBKHcZG67Keee2RcqhGtoWC8OiV97
 5i+eH18UPwJF7Hc8+E64j6cjqDEe7LHNlmd8tknnnCo8H3lnYak0QQXWmqgpVMg3ERP2
 DLwjiU61W5QLn6xpuA/T6efMkob5ibZgG0jQIfSiGM6BJDbPqS4YbWmwsDpNfrSSSocj
 A6Q2loGxnEi8F6uFQUjgVEtU3lHN45U6luyIJOO+FPjyjdDoSXtYe7BQjKSbGxKTha6t
 7ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233126; x=1794837926;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hBMYWxF4MCqpQhvGes4d8FlHIJELgoUuQCBw2En9gT0=;
 b=w3kapMCberxXU24TWavYuQzbH49oxknWOZAw+gGiBJYtayNA2KOdg+1lfX4CLbEmBc
 aVbDNOO+e26oHeWSg1k2SqKvUnLC6OSfJYBJlzKc0P4s/KbJ1aaIbR3QZfiTiL13OD+p
 rX6pduCcCDCGRuZPWJnGRfKEBY7MEb7R2vNmZ+OrothJZn0hypMXzqPK2rMdpphdL1HU
 USRryyj02JyqlEEloxh8OJ8Q7YXH2Woftv13INl2fJDxY4LD0IXrN+Us0DY2lE00N1gn
 mDJCFPdPsLn+LDxvtBgc/D5cQJwCrkGy0gJLrwas59JjiRjFOEcRhB5MtjQbZRpv1Uuz
 bHug==
X-Gm-Message-State: APuU4Z/AQMbtzUVNR4AR+ciRvN1xF4JrzzaQ2UfIf7JsdLqwpT31dlG8
 ZZDR/0H3G/FTZOzFSllbthC/JXYOr6dZWf47A8JzOzCvDcjchYZMQfm82vzuv0D+6nOGfLBHHIZ
 ZqPxklPsoSe5to0YY7DHNxzDOcgcf4g4=
X-Gm-Gg: AYBFou0NtfO7n7XS0wBy54RQzW4iyGZOveZRrwev4LHRt5N+YBEL6pmRWYRcrAvJ3ZA
 oscf1fzBdl7fFnz7cSekyguNv+9MgdJ44FPmm674pU1KQcjA7yzFyE5sdvrdtPS6pn5TQp4in4z
 VjdagiOdi4u07MBIZTMAlNXJvws59QNRXnNNUfCDUtSSqppE10nf+QRg7C5xg9T8hDv3lnpBE5K
 PsXNWLqrBANhwCkwImhJuWJ2Ou7hKEF6EhiH0DngL1mMt9SIMuFO3ZYOgDwFR5OrGkk1RTU/e8e
 8Kz7axJ1tm9SxPIR87S2rLa56CluizBeziSbFY3R/9ZnzRRqT19LLvSqiY3IzLA+P3/6OmKRFRe
 9/YA+hssmZ2mnYiKRvMBOURzqhG2HItNdNMKt6xmKZTaP2aPK0w2THfpaJVJhRZswtgwuzmF8EQ
 eSvTr+B3hUdEZJvxXt/QvqocU=
X-Received: by 2002:a05:6102:6116:10b0:7c3:91f5:26d4 with SMTP id
 ada2fe7eead31-7d2db29ef38mr941152137.3.1794233126392; Mon, 09 Nov 2026
 06:05:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6af17cdb.63afbf66.14af03.b907@mx.google.com>
In-Reply-To: <6af17cdb.63afbf66.14af03.b907@mx.google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2026 09:05:12 -0500
X-Gm-Features: AclHuK8YIrpsTz_YPSzrtqYc-opyD2z4sAfbPJ8JbZ9yoQBStN6cKaRjskmODbw
Message-ID: <CADnq5_Nvfm3sioOfxWpBkh7QgUDBerdzrsAj9HXN9T+2gw3TBQ@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: Raven/Picasso MCLK stays at 1200 MHz after
 Chromium exits
To: =?UTF-8?B?QXRhIMSwbGhhbiBLw7ZrdMO8cms=?= <atailhan2006@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 4:56=E2=80=AFAM Ata =C4=B0lhan K=C3=B6kt=C3=BCrk <at=
ailhan2006@gmail.com> wrote:
>
> Hi,
>
> On a Picasso/Raven2 laptop, MCLK stays pinned at its highest level
> (1200 MHz) after a Chromium-based browser (Brave) has used the GPU and
> been closed. I could not find where the state is set or released from
> the driver side, so I am asking whether this is known and what else I
> should collect. I have the kernel tree and can test patches.
>
> =3D=3D System =3D=3D
>
> Laptop:  Huawei MateBook D14 (NBLK-WAX9X), Ryzen 5 3500U,
>           Picasso/Raven2 1002:15d8 rev c2
> Distro:  Fedora 44, Sway 1.11 on Wayland
> Kernel:  7.2.13-200.fc44.x86_64 (Fedora kernel, not tested on drm-next)
> amdgpu 3.64.0, DCN 1.0, SMU10, VCN 1.0 (ENC 1.15 DEC 3 VEP 0 Rev 9)
> Mesa 26.2.5, libva 2.23.0
> Boot:    amdgpu.noretry=3D0 amdgpu.ppfeaturemask=3D0xffffffff
> amdgpu.gpu_recovery=3D1 amdgpu.vcnfw_log=3D1
> amdgpu.dcdebugmask=3D0x10
> Userspace: no daemon or tool writes to amdgpu sysfs.
>
> =3D=3D Symptom =3D=3D
>
> Idle: pp_dpm_mclk shows "0: 667Mhz *".
>
> After WebGL (WebGL Aquarium, sometimes this doesn't trigger?) or
> VA-API video (YouTube, VP9 1080p) in Brave, and closing the tab
> or the whole browser, pp_dpm_mclk shows "3: 1200Mhz *" indefinitely,
> with GPU load 0% and SCLK back at idle. amdgpu_pm_info reports
> "VCN: Powered down". Battery drain is about 5 W higher, (which for
> my machine it makes about 1.5 hour at my daily usage).
>
> - Persists across tab close, browser kill -9, all fds closed, VT switch.
> - power_dpm_force_performance_level stays "auto" and
>    pp_power_profile_mode stays BOOTUP_DEFAULT throughout.
> - While latched, writing "low" or manual MCLK levels does not move it.
>    After it is cleared, MCLK follows low/manual requests normally.
> - Cleared by: amdgpu_gpu_recover (debugfs), or by playing a video in
>    Firefox (MCLK goes to 667 MHz -sometimes 933 MHz- during playback).
> - Firefox itself does not trigger it.
>
> =3D=3D What triggers it =3D=3D
>
> - WebGL alone in Brave latches it, with VCN powered down the whole
>    time. So this is not specific to a VCN decode teardown path.
>    A clean Brave without custom flags behaves the same.
> - VA-API video decode in Brave latches it with VaapiVideoDecoder
>    confirmed active in media-internals, in each of these variants:
>    default flags, --use-angle=3Dgl,
>    --disable-features=3DUseMultiPlaneFormatForHardwareVideo,
>    --disable-features=3DVaapiIgnoreDriverChecks, even I run with
>    temp user directory with no flags, VA-API decoding ran and same issue
>    continued.
> - mpv --hwdec=3Dvaapi on the same file: MCLK is 933 MHz during playback.
>
> =3D=3D Kernel-side =3D=3D
>
> I attached bpftrace kprobes (with kstack) to smum_send_msg_to_smc and
> smum_send_msg_to_smc_with_parameter and ran: Brave WebGL, Brave
> YouTube, close (latched), Firefox WebGL, Firefox video (released),
> then amdgpu_gpu_recover.
>
> - Before the latch was first observed: 152 SMU messages, all either
>    GFXOFF enable/disable (smu10_gfx_off_control) or two VCN power
>    up/down pairs (smu10_powergate_vcn). No smu10_dpm_force_dpm_level,
>    no hard-min, active-display-count or deep-sleep messages.
> - Between the latched read and the released read (Firefox): again only
>    GFXOFF toggles and two balanced VCN up/down pairs. Brave's video
>    session produces the same two pairs and does not release.
> - A kprobe on rv1_update_clocks never fires during any browser
>    activity, only during gpu_recover.
> - Each read of pp_dpm_sclk/pp_dpm_mclk issues an SMU query
>    (smu10_emit_clock_levels), so the reported value is live.
>
> So neither setting nor releasing the state is visible on the SMU
> mailbox through these wrappers. This would not show direct register or
> table writes. I cannot tell whether the state lives in SMU firmware,
> in the display/data fabric p-state handshake, or elsewhere.
>
> =3D=3D Questions =3D=3D
>
> 1. Is this a known issue on Raven/Picasso?
> 2. On SMU10, what other path can hold FCLK/MCLK high that does not go
>     through the mailbox (DCN hubbub watermarks, DF p-state, firmware
>     internal state)?
> 3. What should I trace next? amdgpu_dm_dtn_log returns EPERM here even
>     as root (probably lockdown); I can boot without Secure Boot if that
>     output would help.
>

Please open a ticket at:
https://gitlab.freedesktop.org/drm/amd/-/work_items
If you recently updated the firmware can you try going back to an
older firmware?  If you changed your kernel can you bisect?

Alex
