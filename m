Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C169C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 07:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333C6113ED1;
	Mon, 25 Jul 2022 07:23:34 +0000 (UTC)
X-Greylist: delayed 354 seconds by postgrey-1.36 at gabe;
 Sun, 24 Jul 2022 22:26:47 UTC
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EAD10F64D
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Jul 2022 22:26:47 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrd0y4VpQz4xD0;
 Mon, 25 Jul 2022 08:20:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1658701251;
 bh=gQfbISkf5MukekHAtySPnc0iPW26vltwRXKWudg8OE4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pz/a2bLbgOln/MNktOnwzJo8BCIlFc6Wo4ZIXIPOMLAGZhu4Af6t23lfRQuz3wQxm
 hrW4x6FQhTBeHs0x8DUmsRzjXYaB0xARf9H1eQR3yMv0vH4iUnjmb1fZG6OjGUb+uO
 gNj4e9qQvaoaDZj/Lg1HT839WVzVCBsyqYqnfvZI9zmdRf6CdRiukX6RKLbbausYrK
 glGqqCjSETWTeWK+e4Pb68/+GJz5bsWRlA28CM2gmztCbXt8kD24WtJfe3vo7o7MZj
 kITq+nB6ZAJvvNuTcMsdI+kaMvg7wLzud7Lbsz+2GB0/YXS7g265s2V1pSdLsgB0E/
 9sIRL2bmxewFw==
Date: Mon, 25 Jul 2022 07:45:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reduce stack size in the mode support
 function
Message-ID: <20220725074500.6abc6a4d@canb.auug.org.au>
In-Reply-To: <20220725073646.068c9cb4@oak.ozlabs.ibm.com>
References: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_MVQUK4cqD8mcOQTupfVR2c6siRyr87pb=BzRgvUG3sQw@mail.gmail.com>
 <20220725073646.068c9cb4@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B_.DbIzJ/hj/Yzv9GCjhY+q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Mailman-Approved-At: Mon, 25 Jul 2022 07:23:33 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--Sig_/B_.DbIzJ/hj/Yzv9GCjhY+q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Jul 2022 07:41:09 +1000 Stephen Rothwell <sfr@rothwell.id.au> wr=
ote:
>
> On Fri, 22 Jul 2022 14:12:44 -0400 Alex Deucher <alexdeucher@gmail.com> w=
rote:
> >
> > On Fri, Jul 22, 2022 at 1:56 PM Rodrigo Siqueira <Rodrigo.Siqueira@amd.=
com> wrote: =20
> > >
> > > When we use the allmodconfig option we see the following error:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_3=
2.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_3=
2.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [=
-Werror=3Dframe-larger-than=3D]
> > >   3799 | } // ModeSupportAndSystemConfigurationFull
> > >
> > > This commit fixes this issue by moving part of the mode support
> > > operation from ModeSupportAndSystemConfigurationFull to a dedicated
> > > function.
> > >
> > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>   =20
> >=20
> > Thanks for sorting this out!
> > Acked-by: Alex Deucher <alexander.deucher@amd.com> =20
>=20
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> Also, after applying the above patch, the following commits are no
> longer needed:
>=20
> 987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSch=
edule
> 8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksM=
ALLUseAndDRAMSpeedChangeSupport
> 5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwa=
th
> f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDET=
Configuration
>=20
> and could be reverted (or removed).

Actually, they are now:

2623c2c90981 drm/amd/display: reduce stack for dml32_CalculatePrefetchSched=
ule
7d5c4fd7c543 drm/amd/display: reduce stack for dml32_CalculateWatermarksMAL=
LUseAndDRAMSpeedChangeSupport
65f946cee7be drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
d35fa7f64f4f drm/amd/display: reduce stack for dml32_CalculateSwathAndDETCo=
nfiguration

--=20
Cheers,
Stephen Rothwell

--Sig_/B_.DbIzJ/hj/Yzv9GCjhY+q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLdvVwACgkQAVBC80lX
0GyHGQf+ObThU5Q/GCSLqkly2sWNL3yAigrdA0q2uy5BUtiHsr3M4B5OAqW0o+Oa
Foc7oEeBaOK0pKdA0ObiSweUspxmNN+1Rr9LqXE7v/NuF1SvjL7hkmIVIaR85VKg
3LQc/6cebmplDVzIXpZMj5LwIbTRP2igRit5aR6BK5/rmTzaxVchcyanEs1BJbMS
CC5CFbfGJau2NfPh2OeG/CbDANt3s1vvZLUE6zp1X3Xln4FPxQJSbV9EhMLfSQLJ
1BPnAeU+eeHhP+QwS5SHg8o0hoD86aO0AXuQX6VikU+zdDjgb8Iy8cm2kBjAGBjs
Pp0HpZChSWxrftOtl1Q9NG5TjX79xg==
=/6QM
-----END PGP SIGNATURE-----

--Sig_/B_.DbIzJ/hj/Yzv9GCjhY+q--
