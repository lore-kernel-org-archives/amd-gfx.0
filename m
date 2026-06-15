Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB64CD98C7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 12:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1C910E3A6;
	Mon, 15 Jun 2026 12:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XbL8QaLZ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D5310E3A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 12:01:30 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so31258435e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781524889; x=1782129689; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqWWQkLmmGqV2xyL0h5Mj/dIWfBnbM5GGgU0emnr4M8=;
 b=XbL8QaLZsKc19+DhlBgRJIFPlNP5MKcf1QPvuf6JN6eoi5n/d3fmUIGGh4DYRQpDAf
 ORS0QA0fLRo8X8xdL9WlA1y54TCtSInTi49r7CIgTz5kn+eEj58vsakZtFDbrxmPLFX4
 g+AK6XjYCcT+dh5gl0xWFWZkTQJt9LDVuEXWSD6HD/4si6bxEYzk0KBz5Vc7NbfYsGf1
 DZquTsYOTcXkT6dsr72HJJqWI07Yg+uFOnn0qjWZU2j8LpReWXydrb89DUWDIiLXuPoy
 aqQDpP7uDK3WyrTXcF7L5M9XZNxthPRqP+J/F5aOu2JrjC7LsvK4HeaCNgZ8I+cKeGvj
 WxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524889; x=1782129689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SqWWQkLmmGqV2xyL0h5Mj/dIWfBnbM5GGgU0emnr4M8=;
 b=DgaD07YQUXCs37nRZz7S7aZ3qUFCiIISvAXKnm/xvNMmJm077TiZbDDvgFK3xweMO+
 wmnaeNwocnmfhoaRtUkbkY+FXEoyFYYsEvO9shLc847pv7zklB8ys0wxs4Qshn6pzjlQ
 WEgF1k2Sj2ZzynncKF++q7gGYT3SO1l4E8DeKhaKeqsH31hHVVBqRtq6SP1+43rZ9tDy
 XZRLOJGntCNQjQQK4kN1MV9TZccYiThyWt19TLtNqL8JHlj790RyAkZGevsJ2im8nGzx
 0DU/hk35a0qHJS6wpnLH9Yv5uZd7nOEXH0Pfe+UcxVEUE/F2NtFCHJatSBVprM4KDuli
 6ktA==
X-Gm-Message-State: AOJu0YxWG/JB5hwgmnpto38Gw4N4aI56woejBTJeq5HcUqfabNSxL8LU
 BcnpSdbTCW7S7g1McsfK0NiXZry7gSm+HX8goRSSkYqb6q/9VJ7CwhG/pIjn+A==
X-Gm-Gg: Acq92OF7fjW2WXlqcIkTGCq/OXViCtOFKFwCDS9tU5SfPJ1bksAo8oCoPEICmNw5atE
 PJ6Yz0rYosEGK3gNecGYW973wRifaUDTwRo3llC5lbhYMNnWyg8ets8+V4bHic9qytcuZRZHAD0
 ZSOHCDegjlN/v/ElE78ZFKDDJwKFhq/TO8Y36dpkA8hYwRjKO+lDP0Iut+MSseSWNOjqQjIq3ih
 sFt01MtsIhDIVMSQhdFkTWLHmMLVG4mTpu9Ijd2S3+H2YlIMKpP6ib/DSAfePD2mEMSjrgHtym3
 2CE4eoqUp26KqVi9XN5AyrfoabQG+gmTlQ4vfoQA1aWt2kdHfJEA4pKntqvKVsu+ijF0e/jgsoR
 C9Iz94LIFeZUfljrkwoX9VdT+oa4ufChKZeXI3t3tYnwmIs1YbGR2pvY9gf2UnNqdnBd52rQPRO
 45ROQehuaWuGNGdYDzwubkLCaIYUv6osbUkxIRVRZ2BhhGNRYNtC3k53suw7OKiMq1DWoJxA==
X-Received: by 2002:a05:600c:c16f:b0:490:6e11:c303 with SMTP id
 5b1f17b1804b1-490ec4e6f22mr168745915e9.13.1781524888655; 
 Mon, 15 Jun 2026 05:01:28 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm337512655e9.0.2026.06.15.05.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:01:28 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, "Jonathan L." <jonaphin@gmail.com>
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 Harish.Kasiviswanathan@amd.com
Subject: Re: Linux 7.1-rc7 regression =?UTF-8?B?4oCU?= ROCm GPU memory ops
 hang on Strix Halo (gfx1151)
Date: Mon, 15 Jun 2026 14:01:27 +0200
Message-ID: <4898269.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <CAPs_=oyWXJuQ4VS7LNQgM=jGKPMDoj1OnagU9YNQY+7aEeabHw@mail.gmail.com>
References: <CAPs_=oyWXJuQ4VS7LNQgM=jGKPMDoj1OnagU9YNQY+7aEeabHw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, June 12, 2026 3:12:29=E2=80=AFPM Central European Summer Time Jo=
nathan L.=20
wrote:
> Hi team,
>=20
> I am reporting a regression in the AMDGPU driver affecting the Strix Halo
> APU (Radeon 8060S, gfx1151). While everything works correctly on kernel
> 7.1.0-rc5, upgrading to 7.1.0-rc7 causes GPU memory operations to hang
> indefinitely. This occurs during tasks like torch.empty() or model weight
> transfers in ComfyUI (PyTorch 2.11.0+rocm7.13).
>=20
> I have bisected the changes in drivers/gpu/drm/amd/ between rc5 and rc7 a=
nd
> identified the following potential causes:

Hi Jonathan,

Can you please bisect which of those four patches causes your issue?

Thanks,
Timur

>=20
> 1.  amdgpu_hmm.c (Christian K=C3=B6nig):
>=20
>   - 1c824497d: Changing the invalidate callback to wait on the VM root BO
> reservation lock may be introducing a deadlock.
>   - 962d684b5: Moving the notifier_seq read outside the retry loop could
> cause infinite retries with a stale sequence number.
>   - 58bafc666: Changes to userptr submission waiting.
>=20
> 2.  gfxhub_v12_0.c (Timur Krist=C3=B3f):
>=20
>   - 40bab7c60: The change to CRASH_ON_*_FAULT bits might be causing the G=
PU
> to retry failed memory accesses indefinitely rather than surfacing a faul=
t.

Your Strix Halo chip has a GFX11.5 core which uses gfxhub_v11_5.c
Changes to gfxhub_v12_0.c will not affect your chip.

Note that retry faults are not enabled on Strix Halo by default, and don't=
=20
behave the way you described.

>=20
> 3.  gmc_v12_0.c (Harish Kasiviswanathan):
>=20
>   - ae4e30f24 and e3fa02872: If the new per-version PTE address masks for
> gfx1151 are incorrect, it could result in corrupted page table entries.
>=20
> 4.  amdgpu_gart.c (Donet Tom):
>=20
>   - ec4c462e2: The updated PTE iteration grouping may be producing
> incorrect page tables when combined with the new PTE mask.
>=20
> Downgrading to 7.1.0-rc5 resolves the issue. Please let me know if you
> require any specific debug output or further testing.
>=20
> Best regards,
> Jonathan



