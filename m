Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D9C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 13:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFFB10E1C9;
	Fri, 24 May 2024 13:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GrvOmnmd";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B8410E1C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 13:17:52 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2bdb57f496eso1993396a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716556671; x=1717161471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlXCQc3o/MB52ttkYbUWNblq+v3TZ5Rf15VGTVZLLpk=;
 b=GrvOmnmdtD4xutznRO/Co2VYMGwzvlKAOn5IAyUo6P6ArZSmg2MZ444HhMZvSaLxnN
 RWS8lxAiCsbXM2zSF+M+VoP138U1duaxvHi2Go15mU3F2uMVjD3ZuAzNgqicAjo+bSO8
 non4yVerCqlY1LQ2G6mUKXyM5AznCpBwMqWc9wYre0qCWykS6O8YOqB838t/++URmhtE
 wJkGin5BXadtgP2fbkn2+EXgalqEI5WHp22XeXI3bG/DL76DIBxscIQGvFkPvsS3PH0i
 pU3Q0v28DHh0pnUtjhdLocwGr2eyNBrDXq3YAjQz0QioyuKBZvPAvhiSI+TJqty9GsJ7
 PIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716556671; x=1717161471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlXCQc3o/MB52ttkYbUWNblq+v3TZ5Rf15VGTVZLLpk=;
 b=V9znP+53xZ3lATwhDJBDLHdFRZNV5ZvnrONnRdNUlGiWM0SRNaAyH9iJpgqfNLa+0G
 YI/JfMJajLfYEGQhi7J+L7FWPhwI37tX9ieGc4ojs9l1WZU1VIfH9om2ntR4PWs4crJ2
 ZJZOogR19ZyFZUZGUuz2OCLTjjaTT7Af0Vp7Q6qws3Dsw9wccNB9u1cx5QP76kyuwcq2
 Igmxmh2bL9Dt4/3TRqRED1qsnGIUVMjMG5xofr7Pjob6ozHPNCpK72y8rBZLcbv5rfp/
 uu+i90dnzMI7d5BABzbWLNrwg4uSaG5Ort/BkT0dSOAmDOm+P5+ANKOAOQy7hbX19074
 AAhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBWNf1uNwHvRGOWE5s3GMoPDhyTIlsqe/bS2Ihbc2hK6YSNGQTbIzocmhBP7hoDMaFJrvbKn30VfmlqwQUCjVPxwQG42lhuisbVlmVHg==
X-Gm-Message-State: AOJu0YwXklY+yMEWPta75UaOYfIIBBFYjKtaXAyEafpKFt4d1MwPpypm
 smFrqwRKwdOrymyfWIbJzz5I7sOqdxIweFO3pHDamwaDMSfyipyHGwvR+/6GEVBF3hAVOzz2oLP
 KxulmxpoCmJ9SsGEqYMpBqCmGNkk=
X-Google-Smtp-Source: AGHT+IEwoe8jd0oZgn4cZUVcBCDA8tK4CYreDWY9kJHQp57IWOrilIahqDCBhTgwJSyB8G7rI/D9MAOMBfFiB7nWxpM=
X-Received: by 2002:a17:90b:1888:b0:2ac:5d2d:12ac with SMTP id
 98e67ed59e1d1-2bf5e84abfdmr2678646a91.5.1716556671509; Fri, 24 May 2024
 06:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
In-Reply-To: <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 May 2024 09:17:40 -0400
Message-ID: <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Guenter Roeck <linux@roeck-us.net>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Fri, May 24, 2024 at 5:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
> > Now that all previously-supported architectures select
> > ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instea=
d
> > of the existing list of architectures. It can also take advantage of th=
e
> > common kernel-mode FPU API and method of adjusting CFLAGS.
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>
> With this patch in the mainline kernel, I get the following build error
> when trying to build powerpc:ppc32_allmodconfig.
>
> powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_=
mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm=
/amdgpu_dm_helpers.o uses soft float
> powerpc64-linux-ld: failed to merge target specific data of file drivers/=
gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
>
> [ repeated many times ]
>
> The problem is no longer seen after reverting this patch.

Should be fixed with this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/5f56be33f33dd1d50b9433f=
842c879a20dc00f5b
Will pull it into my -fixes branch.

Alex

>
> Guenter
