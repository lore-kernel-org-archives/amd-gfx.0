Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F03C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 20:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7AED89A16;
	Wed,  8 Jul 2026 20:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rtUvn8Jm";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3BF89A16
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 20:11:04 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ca7605ce4bso1609295ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 13:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783541464; cv=none;
 d=google.com; s=arc-20260327;
 b=V6HKjLlBExM+e7im7hpbyNnIJiW+G0Uesm1/Xt9P8Q2RwgO13SXK6Myq0bltkcBDyl
 QPJlRJoHTGI49vFHYeFG5xwYePYShbT6Bf9skzKuu+JUZ0dWT9a5VcFzGmimox1sGben
 cX9o7T0WJMix8tzHBbsmLPMTKxAdbfWuULsXfsAKDQyI/k4x0CLnAL0yTOXKPp7HtG9Y
 5mYRBkHv4BRC1FYApzCuOEfRev2btHBu6+EjW/ejrWAwRMbd1slCSYuKH0MWKc94zj1d
 1jv4nc5LILeE+XrYqOjewvjt/1cemAvtnA1ZteaV2RTBNeuHysbzgwWgdYFXxRtRBZFK
 P41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QZLNjVpmyi0d+h50Tfa22Ci3luNx0l9N4UfOz4jz/fA=;
 fh=hzoWuElyInASonsFCViuzUgDeWKlwzi3eZ8quAjGESY=;
 b=CvG+ZdBOb8+qise74Z+aD8hIZ5SkPOvDfw7rekmSf7dUW6diAvYgmpFOqThFiddiUN
 xI7kjn2eXPsf0iCysU16CKX5ould2gK6C+s7egt//EQiQt08bikYJmQ5WORlsJ5l0tnZ
 amHC0kelwWMIMoB5szfLnKRABkWoFPoHD40p/hinRmSwWg2KXIMx1BmWAT/V/Jgfc5Y3
 Quq0jJmaEHFCoy8oT2t7fyd6mOX5by/vFt+nPuNE0EdmGGdMUyJElRnTZSlx8Xp379mZ
 iNoni9RNP7WGybcwmM1Uz4KcS9XTMI1QOYfzhjiU/J//c+n3/supMj8+fZZUFo+y0dlE
 Y8UQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783541464; x=1784146264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QZLNjVpmyi0d+h50Tfa22Ci3luNx0l9N4UfOz4jz/fA=;
 b=rtUvn8JmBWvFyFtRKTBKX3j6stHzjHqH28oES3LYVXcBnvEwNbEInZTz3+1uBbPx2M
 Eew29jmWOv9zOP1hgddkzpnpKYa4CAGqy4o8cWNPAjgi60QXTWI77WbV0xo7VqnFWAej
 E9xePAOsfP1pBjCVbbk8u1S6Kj/Ns39nYa54u9wZCR14n3AGrhLfVkrGVGAbZLrLEM8c
 GkTb55D5GoY5CsUB76q0AeFcOxGgyOYheSZnklPfhdnMcCokuinDfLqDAAt72m7buRH+
 hxn1LfHmedmDLPZDLHizEx/DCUp+NuUm82Hy2rpCZHwQmyWpekOgHzdzrF2Qd0/fPOcy
 EIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783541464; x=1784146264;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZLNjVpmyi0d+h50Tfa22Ci3luNx0l9N4UfOz4jz/fA=;
 b=X70QfKhXlQEv0WjRZ0zQJdWrXbLfYgQoZG3cFx2KoWkFEyba+JZHKodioTqonZwADV
 q+LKzrFrpeB/tNwWr6xdx+e2EHoTiI0ErqkVKnb4tVW1dR28wbMFC1UNMg8JtULwwhM4
 JYwhhJqGBEXtxmlZTTxLSw0dxKnC2Mmny323mVsbgie5DlqRz6hYPM2jV+pVedXFTtU4
 AzykBh7HLx9yRd2kY0GT9Gs1Lug74NvnMPJtowxVZb7UzHbm5aPGQyIfjbxEK8yYUGv3
 fXdDGtlCq3vQMypHT+W7VQfRqLju00BNT5h0hUtumzINAMpWixZxzzXQfpg3NOmv+hXJ
 gQag==
X-Gm-Message-State: AOJu0YwCIXU0qIwPWwEeA6eBWArgBn4IB8bDW+ER1psYNkC9Qm4VvDQE
 HzmXnodz2lsaOj8doHqDjoEGWlUWAoL7bZK1LyzRYS/H7PuxLKOM8O/AtHCi3TqLRXmSb5zQw2x
 7RoIalZ11XBEpc1GLkPNfxd1QaiLqJWhhKQ==
X-Gm-Gg: AfdE7cnJNd+q17VahMw85pyYnUAV0fK8eXix+EDITKSIhnPPgaSNBuJOy9Tspn7cpKE
 V+5UyEH8MGuenwprzMqZDoFIH4B6RmEb7VLL0sFj1wraeCYjNDuEtve1Jlbw8JSYD9gQjGky0uN
 I6lnmgZoflE3kKVnkEcCh2GEVb9+5h4873wbn5nPeb/QjhdjyGN9MhsrZIhwrprpA8xINiCL56D
 KHjcragxZKnIzWrxkYwtzSlmOdjd48wRLeCcOeaQ8jlmYdwo+ZWpasNXoNZTFdeG1f/RT5xWdNk
 FddOoSFM/hPVXC+a0nrkvJpFkjtGiMLyk8P7yz4ciSJgnf9VMDlBtkAU+nE=
X-Received: by 2002:a17:902:c412:b0:2ca:bca8:109b with SMTP id
 d9443c01a7336-2ccfef8d44cmr7301935ad.5.1783541463812; Wed, 08 Jul 2026
 13:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260708193518.702584-1-mario.limonciello@amd.com>
In-Reply-To: <20260708193518.702584-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 16:10:51 -0400
X-Gm-Features: AVVi8Cek1YhkOgD8szXAnN301KlsSILgWbwNdd2ISjTlq0HW74Y_n6YQqYAbUbI
Message-ID: <CADnq5_Mc--qTm=oj2PGEdydBWbRS8j_rF5nK70QcJeYpC6syHw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Allow matching devices with different bus numbers
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Oz Tiram <oz@shift-computing.de>
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

On Wed, Jul 8, 2026 at 3:44=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If a user has specified pci=3Drealloc,assign-busses on kernel command lin=
e
> then it's plausible that the bus number in the ACPI VFCT won't match
> the bus number the kernel assigned.
>
> In this case the device will fail to probe because of the mismatch.
>
> Loosen the requirements on VFCT bus number matching to allow this case
> but log it with dev_notice().

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cc: Oz Tiram <oz@shift-computing.de>
> Mario Limonciello (5):
>   drm/amdgpu: Fix VFCT bus number matching with soft filter
>   drm/amdgpu: Release VFCT ACPI table reference
>   drm/radeon: Modernize VFCT error handling
>   drm/radeon: Fix VFCT bus number matching with soft filter
>   drm/radeon: Validate VBIOS signature in VFCT path
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 62 +++++++++++++++++++----
>  drivers/gpu/drm/radeon/radeon_bios.c     | 64 +++++++++++++++++++-----
>  2 files changed, 103 insertions(+), 23 deletions(-)
>
> --
> 2.43.0
>
