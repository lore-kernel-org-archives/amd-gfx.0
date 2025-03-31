Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F056C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 13:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F8610E418;
	Mon, 31 Mar 2025 13:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t/KMf7Ad";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B4310E418
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:23:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AA7D44CB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE9C4CEEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743427420;
 bh=BNvLxh5zFpguHH6d2CpK/g7iaez1WKqjMuDikvk/WsE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=t/KMf7AdlJOt6yO09WNRUYCsZ3Pg/d9as77b3kAXaKnYEqjsLo8zJ3dcYd/tW5K58
 adbprGvchIGbgCsCH1UH3FuL32t2/DGULEWY/fbhbYWhFWu22hebNSo0ZDEWrnhqa1
 /JnZ30HmAnK+1829u+jf/s+RBNs0+ZFtyAkg5iBLPovVsiUZvv6Y7YVWJkczF4XeeO
 r9yY2JimDoJRBXB+aOHMlNkedEvj77RZmrgIGWBV/2LBHZ8D5bz0DsTR2cjQob1v/Q
 a2t1sgLfv1ihcVaLEnO9Jh2N56BbXovPourDE1rjEski+PSMjBs4sMIjAmlKCUW5Qt
 glp+T9G4+mQ/w==
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-6021e3daeabso2096001eaf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 06:23:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVTZoDH0JV4Z5bBAGfrcUwzESmbAz0zEetjoUS9g0qZWD0DXkh+eOJHHkbI3uk9hjANsGOcvFiF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx9xks662Bus6WeoT7UyDNUmc5dsgm7aDnFVAs97DfYUZZmN16
 /LsO3EoLuOpuOo+G3qNQaCJF+2R1xp5eWGesPzliHcFqNfvKsd5uuDoUoe7H8PHjGa2jhxoqmAd
 cQejpiwT3R/Dr4fx1XubptVAlhr4=
X-Google-Smtp-Source: AGHT+IFpjRAG9jxkdHVT1kiTjIYNaocNQRJBpnWXCk7BJLlLGdHW5Rg4gN7sPQ9eXfl0WvbDapdST+EC1XbE9rhVC70=
X-Received: by 2002:a05:6870:610d:b0:2c2:519e:d9a9 with SMTP id
 586e51a60fabf-2cbcf765ef8mr5111966fac.24.1743427419888; Mon, 31 Mar 2025
 06:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
 <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
 <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
In-Reply-To: <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 15:23:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hy7ge+vPgNXzo89=qu7pP-tPgbjUPRHUMdwUnSTpVXQQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq2qoSpp3qytZmIhGEF74CJIGeXYn3IZnod2sw1TIK9OOzCAOUj43B2Xj4
Message-ID: <CAJZ5v0hy7ge+vPgNXzo89=qu7pP-tPgbjUPRHUMdwUnSTpVXQQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Mar 31, 2025 at 3:04=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 31-Mar-25 1:46 PM, Rafael J. Wysocki wrote:
> > On Fri, Mar 28, 2025 at 10:09=E2=80=AFPM Gergo Koteles <soyer@irl.hu> w=
rote:
> >>
> >> The _DDC method should return a buffer, or an integer in case of an er=
ror.
> >> But some Lenovo laptops incorrectly return EDID as buffer in ACPI pack=
age.
> >>
> >> Calling _DDC generates this ACPI Warning:
> >> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
> >> found Package, expected Integer/Buffer (20240827/nspredef-254)
> >>
> >> Use the first element of the package to get the EDID buffer.
> >>
> >> The DSDT:
> >>
> >> Name (AUOP, Package (0x01)
> >> {
> >>         Buffer (0x80)
> >>         {
> >>         ...
> >>         }
> >> })
> >>
> >> ...
> >>
> >> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
> >> {
> >>         If ((PAID =3D=3D AUID))
> >>         {
> >>                 Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
> >>         }
> >>         ElseIf ((PAID =3D=3D IVID))
> >>         {
> >>                 Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
> >>         }
> >>         ElseIf ((PAID =3D=3D BOID))
> >>         {
> >>                 Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
> >>         }
> >>         ElseIf ((PAID =3D=3D SAID))
> >>         {
> >>                 Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
> >>         }
> >>
> >>         Return (Zero)
> >> }
> >>
> >> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extens=
ions/output-device-specific-methods.html#ddc-return-the-edid-for-this-devic=
e
> >> Cc: stable@vger.kernel.org
> >> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if ava=
ilable for eDP")
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> >> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> >> ---
> >> Changes in v2:
> >>  - Added comment
> >>  - Improved commit message
> >>  - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc9=
5ee8be28aa811.1743129387.git.soyer@irl.hu/
> >
> > Hans, any concerns here?
>
> No the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

OK, applied as 6.15-rc material, thanks!
