Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9113CCA473
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 07:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A0F113F39;
	Mon, 25 Jul 2022 07:23:35 +0000 (UTC)
X-Greylist: delayed 387 seconds by postgrey-1.36 at gabe;
 Sun, 24 Jul 2022 22:23:49 UTC
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B67112270
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Jul 2022 22:23:49 +0000 (UTC)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.rothwell.id.au (Postfix) with ESMTPSA id 4Lrcwp4YV2zyZr;
 Mon, 25 Jul 2022 08:17:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
 s=201702; t=1658701035;
 bh=YGEaeUbKiRDCYYWkghSCOynyRlyKXuIsRAl5tH12Ez8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HqTwCWmOpqHbh/28pN24TveaDZC87Lh8Ltfa50wyP5V+beR92Yty3f62lOzrw3iCw
 BZacyN/KU/mS9nqoA5uZZsCd78wReBITwHlZuRXjuFijbEN6EhyuKRfk1o/UHM/OOp
 QRlAPIR6M+1elrY9fs38vs7+lZuMEMFpXjL9AsdgVwZqF9IEnQxkLqTP5MmWCzbC92
 srp/fiUnCaHORvalTe5roNOUjGq4VXbmaHGSj3ws0JZ73u9DTSQYPuObtDJ7qN1ZIt
 1qC416/DDWWKmbAXgmaTEAGkRe6TAdcBP1QECdrTz2g4dUkos90JNFn7346LfHIaOc
 dTqv2Hv3VNAcw==
Date: Mon, 25 Jul 2022 07:41:09 +1000
From: Stephen Rothwell <sfr@rothwell.id.au>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reduce stack size in the mode support
 function
Message-ID: <20220725073646.068c9cb4@oak.ozlabs.ibm.com>
In-Reply-To: <CADnq5_MVQUK4cqD8mcOQTupfVR2c6siRyr87pb=BzRgvUG3sQw@mail.gmail.com>
References: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_MVQUK4cqD8mcOQTupfVR2c6siRyr87pb=BzRgvUG3sQw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VRUBk4vBa=Hq0Nnl8SQg=C3";
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--Sig_/VRUBk4vBa=Hq0Nnl8SQg=C3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 22 Jul 2022 14:12:44 -0400 Alex Deucher <alexdeucher@gmail.com> wro=
te:
>
> On Fri, Jul 22, 2022 at 1:56 PM Rodrigo Siqueira <Rodrigo.Siqueira@amd.co=
m> wrote:
> >
> > When we use the allmodconfig option we see the following error:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-W=
error=3Dframe-larger-than=3D]
> >   3799 | } // ModeSupportAndSystemConfigurationFull
> >
> > This commit fixes this issue by moving part of the mode support
> > operation from ModeSupportAndSystemConfigurationFull to a dedicated
> > function.
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> =20
>=20
> Thanks for sorting this out!
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

Also, after applying the above patch, the following commits are no
longer needed:

987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSched=
ule
8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksMAL=
LUseAndDRAMSpeedChangeSupport
5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDETCo=
nfiguration

and could be reverted (or removed).
--=20
Cheers,
Stephen Rothwell

--Sig_/VRUBk4vBa=Hq0Nnl8SQg=C3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLdvHUACgkQAVBC80lX
0GyLDgf+LV4BCYZfKdiCg6zMGyjXPuRntBC/8p7IVPDmJ00ji1p8tVi15V+JafDb
1nRZxsb+11d7vbyzbrnDCPgy381FYspahRuA0vcnVFjGhbNXsrJpPUjulqQNksGs
XkWbV/xA0YqAXxGiLucD0AR2FNcg5Pjf1fP3gQxYtNetUgHaWE/soZwQZHU3NN4I
3r6zxIU4x2c95L+AAiaXqhswddKmekp7c+Tj2zyTIYvYniyx90bbsGFnPWJlaZGG
d8y5GGt57vPOcKVakuwGp1O12psiwzKBV4qD6/SO8WmIYgRAMTeYyfke3gn3l+SS
jlkXdArW3OsavS4eDPTKN5PSm21RyQ==
=hhyT
-----END PGP SIGNATURE-----

--Sig_/VRUBk4vBa=Hq0Nnl8SQg=C3--
