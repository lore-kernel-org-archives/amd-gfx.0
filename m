Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7238CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 07:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2C210E4F0;
	Mon, 22 Jun 2026 07:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CvjxVwo/";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C2010E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 07:27:00 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7e92cb77209so2091873a34.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 00:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782113220; cv=none;
 d=google.com; s=arc-20240605;
 b=OyBrq7HKXCqUWNbAr4xJ5zpH0ZtqeUX8dluKM16PGqxjIVgu3JpoVzIz5SA2k7EAgs
 nUE8lHE9oHoEFhuOv/4CaNXcRVH0tIcNmxksT1nhtamvdEzKHF/N/PJY9QPa/+S9rRSK
 nIpMBz8k3RfkWJQIkLOx4qGu5J7jirF3YVmio9PsCv/8VemuWneprCayzamKa29iSe76
 AiCJb3vFsPULxTJ4PwLymeG4MfY6LXukQcSEjH21Aa+4SJa1JS/UND5FiFurFdA27mOV
 EI6sK6kx3qJ8RQKT1KmkCgmTKFX142VKuXe62D6ihEm72meC3NMShcGQ68HO06scqBYp
 VCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b7FQ1aR5OdpNqu3r0SBRqrV7xGbQqLLo0aQcbDX73CQ=;
 fh=iYv/3yi8WuLe+NLVxQ/LqDQuoNcCBqSo1OPLwfIw798=;
 b=LJJjZGEK0Juja0Hapa6gzEz97/4mU5+uXAhszv2mzDV4kbB4Ktqsift5vOyqgd0/hd
 U5RDA3wq1c4xZUcJiki6AtG/LExUP+oh0/0iQF5IHd0HSXq7fiwCplpuMbufDn1ZD5Fy
 g9ipkPeAb9sBbUuYDscDGOcQ6MsY/hBktbV+ifHjjpwBM0Ajz5GVjIwo2zf56TmlYYrT
 wUI4DIyycWQwYWWjsksWcTEyfYxIQbrbatttlPEnkPSDsUi02fKB20CUXSdQ4n2HuD5E
 jP4ZagpPGLS727WcriLFPiODSMt4kxGH8qkNbAqi41/QH3EgJr/a7AABGiCQrnDd1zeW
 qiJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782113220; x=1782718020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7FQ1aR5OdpNqu3r0SBRqrV7xGbQqLLo0aQcbDX73CQ=;
 b=CvjxVwo/5XXEcli1YY4aOz/xNYBp9gbfqt7lIRcxyjiD+1IysO2KhB8yH7Xfc3n1cO
 bRow0ONNc9N/vdySOjKYf7agwaAmmOeugOc642TGM+3P7r1itqhia8xgbzLgg5Duvecl
 vu4bWAhQgFFeU2jHCYGXqUCFlEcCLAxFaGEfwqc8Do+5tRClzVCNjdw4gjZesP1zBlhH
 8WXed2GcdYLX4V0j7X8MfKxm4dvIUSfqreCh7jBfsUH9XIQOL9B9Ga/AcMfHkJIZZCP4
 jGpV+BjL8+eQcopj/LAHAYk0Qlays34Sr1yrLUpVJVd63m9MJ9UQXVYbhsVlwpWwFItP
 EvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782113220; x=1782718020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7FQ1aR5OdpNqu3r0SBRqrV7xGbQqLLo0aQcbDX73CQ=;
 b=UOypededsaEiU2zW3xRZ7DrjtN3FinxSZ8LfOcB3ALhRIiLLuT5PMtP592s5zRXF03
 VCX5zNHaa0OaJ2JJaV7uxhdpsMQkbGBiG6xxWuq6Waz/PxYJQPtajQ4HcAdFSJHq8pnL
 ny+UjId/mCL8EErZTVHSgha2xCWssar0DOaF7QOC4n6PNL/F63Q6gRx9Vd2s/Ys3YDvB
 zNSGcLygH6W+TbF7lzLG0WgDgc6d7WVSFw++4X7ed/qRtE7xkw6cP+8Pa4ej3k8zn53j
 /0XHHVnvtm69f/YA534aA2NQ8q17zbUnk3vwSsZFsgTtutsLqGcVHPru9e7CwxO8YTmV
 x3gA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m3aU2qQH6FWBEiGWLMn4fwmXXbwFt13C87WBpZNCMAkgQV8SysQbBITtvibxfM7scc81PpIwQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM+om4Rn3FDY+FS2k5jNPvoaUsUVm9VvijZ66JdAjE1Z31+EWo
 7wtVKeuFCBDavdyQkmwAslYPFTnpwMVOx1fv53vXMXECTgaX6Wu2aD0BrffmbtE2mFaZ5wyPOHq
 H9SVmV53Fb2g8694z/D6PBYTK6jSUMcI=
X-Gm-Gg: AfdE7cnVfzsmhxKgIKKp2h9KQfoaW4J8YwbhlGTKm9FdQFu6gGdDYHPReNH7GO6Is0v
 CdMCzJT/trNWRtYdRBBfH1I2pD/lK7AW1QFNMuWDMk/4vczd9Gn8BUrsI+LIrsub52fPXImnIS7
 H63ClWQkP9+cyzsyNLhsLDyLa/LWuTBXlE54q5tkVHoW8MU1j4n6HWtgQFjVfG1w16c/DH2QamG
 BniA2ELCwDXiJIyqYgeT7S0qwacoccv7h9Vsn0Wb3PL59r01hPzJ81TyR/ew+yhq4nrl07Tvuk=
X-Received: by 2002:a05:6830:3493:b0:7e1:f7e9:327e with SMTP id
 46e09a7af769-7e9323e5412mr11396887a34.22.1782113219802; Mon, 22 Jun 2026
 00:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOuCXr4R+WW60KNuWNS2MqzE9w6iv-t_ykbwmhqDSABAQ@mail.gmail.com>
 <c084c555-e4f4-48a6-9fad-175932acda01@gmx.de>
In-Reply-To: <c084c555-e4f4-48a6-9fad-175932acda01@gmx.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 22 Jun 2026 12:26:48 +0500
X-Gm-Features: AVVi8CdL5HCS6SzL7JevAxlu8t7MCcOBjE3b4wSUAQVcGGIU9Sqd3fb5ZlnE_Hw
Message-ID: <CABXGCsNAEapxA3gZis6XCg_KWxzRGsxiwR9-A7Dh-+iDNGpaNQ@mail.gmail.com>
Subject: Re: [REGRESSION 7.2] drm/amdgpu: ~275 SDMA jobs per sparse VA bind
 since 4cdbba5a (RE Requiem 90->4 fps)
To: Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
 Linux regressions mailing list <regressions@lists.linux.dev>
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

On Mon, Jun 22, 2026 at 10:44=E2=80=AFAM Natalie Vock <natalie.vock@gmx.de>=
 wrote:
>
> On 6/21/26 22:55, Mikhail Gavrilov wrote:
> > Hi Christian, Alex,
> >
> > git bisect points to
> >
> >    4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
> >
> > as the first bad commit (its parent tests fine) for a severe
> > interactivity regression.
> >
> > It was merged during the current 7.2 merge window; it is not in any
> > released kernel yet and will first appear in 7.2-rc1.
> >
> > Symptom: Resident Evil Requiem (re9.exe under VKD3D-Proton, RADV, RX
> > 7900 XTX / Navi31, gfx11) drops from ~90 to 3-4 fps the instant the
> > camera moves; still scenes are fine. The previous bisect point
> > d352990bcaab is smooth.
>
> I already fixed this in a patchset[1] that should be on its way - seems
> like it didn't make it into rc1 at least?
>
> Christian, Alex, can you make sure that the first patch from that set,
> "drm/amdgpu: Only set bo->moved when the BO was actually moved", is
> included in a -fixes PR for 7.2?
>
> For the record, I intentionally did not include a Fixes: tag in this
> patchset, because the commit was not merged anywhere but
> amd-staging-drm-next at the point of writing, and the same commits in
> amd-staging-drm-next and upstream have different SHAs. AFAIU, this also
> prevents me from telling regzbot that a proper fix is underway for now.
> Not sure if there's a workaround for this?
>
> Best,
> Natalie
>
> [1]
> https://lore.kernel.org/amd-gfx/20260529153051.973261-1-natalie.vock@gmx.=
de/

Thanks, Natalie. I applied that first patch ("drm/amdgpu: Only set
bo->moved when the BO was actually moved") on top of ef0c9f75a195 and
the regression is gone -- camera movement is back to ~90 fps.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Re regzbot: since I opened the regression, I can link your fix from
here without a Fixes: tag or a matching SHA -- monitor just takes the
thread URL:

#regzbot monitor:
https://lore.kernel.org/amd-gfx/20260529153051.973261-1-natalie.vock@gmx.de=
/

Later, once the fix lands upstream, the entry can be closed with a
regzbot "fixed-by" on that commit's SHA.

--=20
Thanks,
Mikhail.
