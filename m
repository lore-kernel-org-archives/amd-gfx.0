Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C458910775E8
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 16:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A7910E462;
	Wed, 18 Mar 2026 16:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DgT2k0w4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BB010E45D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 16:29:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C25F161119
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 16:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608EDC2BCC9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773851344;
 bh=PJ8mloUGDA8ehxs/h4FzGNYzy8GviZKual04ClMGe4Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DgT2k0w44MSp7UcVOrGuwuhsFQHI+gCGXnvQPieMCYBeU0YJRpRR+UqIOGFEBLvsc
 Cruk707J8mgIe0etqcvafy6FyVVTSp+BnlwypK93FsXzSaV8n+Motv35aR17Tt4+GO
 hEG6Znfa+B5wifyHOFJVf6F8gJqwts9YaxEcNMtINR9KcTsxj0MaZnpPlUFR3/v3PW
 UVPdXrdKcQxZ71gYrchrhatXNrKJqqjFI7CKwZ3F8+Vl9E3S/1eVXGoIKyr3U5okLC
 ZQAItxssWEVHMGDXsOHprvrQ/4OOlRNDIoYdQPg4EA26vG8V9cwhk5ugKligLi8VxO
 KNX/RHZSqlpcw==
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6676d55d01dso100019a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 09:29:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNHsLm3qy6p+2ZqHfVo3PnQk4Kdmji4u6yvJ23YxIHHR0JLxYepFFPnArxt6RFJuTnVaK1dGsr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfkbTQZp1D2vBaKrSg2WK+YcI2Pt/sZQ5t2zoeEk/YosRH2aZ9
 tSzwmd8fVEx4h59+iuDdMG7DdpDQ+q+u17cScFgvFq84WeEzyMwTGbPFgU7CVRUo+io7T2vAh3R
 EAaglh8wqOF0wQ0ylSrCPh01AASIkpg==
X-Received: by 2002:a05:6402:5203:b0:65b:a2b5:5320 with SMTP id
 4fb4d7f45d1cf-667b2c0bf49mr2499956a12.26.1773851342697; Wed, 18 Mar 2026
 09:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-62-jim.cromie@gmail.com>
In-Reply-To: <20260313132103.2529746-62-jim.cromie@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Mar 2026 11:28:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+n2rWsRA-fdB+csE9+A_tCL5fjSdGWxA+1P6Sbafs7Ag@mail.gmail.com>
X-Gm-Features: AaiRm50ju3fsACxEcH_HswXEtjwvyHmrjX0DVJy6kYjxOD6TIzPhRqn10EQHqBA
Message-ID: <CAL_Jsq+n2rWsRA-fdB+csE9+A_tCL5fjSdGWxA+1P6Sbafs7Ag@mail.gmail.com>
Subject: Re: [PATCH v11 61/65] accel/ethosu: enable drm.debug control
To: Jim Cromie <jim.cromie@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com, 
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Mar 13, 2026 at 8:25=E2=80=AFAM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> ethosu.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
> to tell dynamic-debug what classmap enables them.
> Also include drm/drm_print.h explicitly.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/accel/ethosu/ethosu_drv.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
