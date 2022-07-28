Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B7C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 12:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0BE99BF4;
	Thu, 28 Jul 2022 12:58:59 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B46599BA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xX+K1uZazojeaIE/CJa7lDvaEJA2ApElBCfBa+lw1z4=; b=MlJmj//yF9dfGg0ALbY5MfFo8W
 +hnvquMRAwapOtoyN2ZPgvgSQ8yIaKGIOelO/WYdo7Q+1Bx4KGGwDlSiAYg1a0Dkh3cIwbCdPNCxH
 Si6gdfRQsObTtnrUawPxzvut/ZI6SYRt9rqBfeF8Bc2/5cnc/+11XFC0mVKKkDHwnp6ENQt8BYm1X
 WjlU/A6GS9Z9Qyids1+4wVKfLNHMApsW2CxQzYl02jU3wYXqUn/3Jf7glE4qTTEAcHiVPbf0LM1ru
 XEYnx5cHn2hLZJWveaud++j+vQDOGH3kbAYxfSCVbM/+WaA2Oe9Tal+jkIe1ZyFEkgxcHcoq7QMgY
 StxGQpSA==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oH36I-009tqZ-NN; Thu, 28 Jul 2022 14:58:50 +0200
Date: Thu, 28 Jul 2022 11:58:36 -0100
From: Melissa Wen <mwen@igalia.com>
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 2/4] Documentation/amdgpu/display: add DC color caps info
Message-ID: <20220728125836.jsldm5rrz7dvlbiz@mail.igalia.com>
References: <20220716222529.421115-1-mwen@igalia.com>
 <20220716222529.421115-3-mwen@igalia.com>
 <facabe6b-182e-4902-e8a0-9ca66ffe1994@gmail.com>
 <b872acc1-f844-cff4-b375-494a93654e04@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q4xbrqhrluimaryv"
Content-Disposition: inline
In-Reply-To: <b872acc1-f844-cff4-b375-494a93654e04@amd.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, alexander.deucher@amd.com,
 20220716222529.421115-3-mwen@igalia.com, harry.wentland@amd.com,
 christian.koenig@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--q4xbrqhrluimaryv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/27, Rodrigo Siqueira Jordao wrote:
>=20
>=20
> On 2022-07-17 19:28, Tales Lelo da Aparecida wrote:
> > On 16/07/2022 19:25, Melissa Wen wrote:
> > > Add details about color correction capabilities and explain a bit abo=
ut
> > > differences between DC hw generations and also how they are mapped
> > > between DRM and DC interface. Two schemas for DCN 2.0 and 3.0 (conver=
ted
> > > to svg from the original png) is included to illustrate it. They were
> > > obtained from a discussion[1] in the amd-gfx mailing list.
> > >=20
> > > [1] https://lore.kernel.org/amd-gfx/20220422142811.dm6vtk6v64jcwydk@m=
ail.igalia.com/
> > >=20
> > >=20
> > > v2:
> > >=20
> > > - remove redundant comments (Harry)
> > > - fix typo (Harry)
> > >=20
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > ---
> > > =C2=A0 .../amdgpu/display/dcn2_cm_drm_current.svg=C2=A0=C2=A0=C2=A0 |=
 1370 +++++++++++++++
> > > =C2=A0 .../amdgpu/display/dcn3_cm_drm_current.svg=C2=A0=C2=A0=C2=A0 |=
 1529 +++++++++++++++++
> > > =C2=A0 .../gpu/amdgpu/display/display-manager.rst=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 35 +
> > > =C2=A0 drivers/gpu/drm/amd/display/dc/dc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 74 +-
> > > =C2=A0 4 files changed, 2995 insertions(+), 13 deletions(-)
> > > =C2=A0 create mode 100644
> > > Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
> > > =C2=A0 create mode 100644
> > > Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
> > >=20
> > > diff --git
> > > a/Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
> > > b/Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
> > > new file mode 100644
> > > index 000000000000..315ffc5a1a4b
> > > --- /dev/null
> > > +++ b/Documentation/gpu/amdgpu/display/dcn2_cm_drm_current.svg
> > > @@ -0,0 +1,1370 @@
> > > +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> > > +<!-- Created with Inkscape (http://www.inkscape.org/ -->
> > > +
> > > +<svg
> > > +=C2=A0=C2=A0 version=3D"1.1"
> > > +=C2=A0=C2=A0 id=3D"svg2019"
> > > +=C2=A0=C2=A0 width=3D"1702"
> > > +=C2=A0=C2=A0 height=3D"1845"
> > > +=C2=A0=C2=A0 viewBox=3D"0 0 1702 1845"
> > > +=C2=A0=C2=A0 sodipodi:docname=3D"dcn2_cm_drm_current.svg"
> > > +=C2=A0=C2=A0 inkscape:version=3D"1.1.2 (0a00cf5339, 2022-02-04)"
> > > +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape
> > >=20
> > > +
> > > xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd
> > >=20
> > > +   xmlns=3D"http://www.w3.org/2000/svg
> > >=20
> > > +   xmlns:svg=3D"http://www.w3.org/2000/svg
> > >=20
> > > +=C2=A0 <defs
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"defs2023" />
> > > +=C2=A0 <sodipodi:namedview
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"namedview2021"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 pagecolor=3D"#ffffff"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 bordercolor=3D"#666666"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 borderopacity=3D"1.0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:pageshadow=3D"2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:pageopacity=3D"0.0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:pagecheckerboard=3D"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 showgrid=3D"false"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:zoom=3D"0.56413987"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:cx=3D"1003.2973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:cy=3D"691.31792"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-width=3D"1920"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-height=3D"1011"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-x=3D"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-y=3D"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-maximized=3D"1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:current-layer=3D"g2025" />
> > > +=C2=A0 <g
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:groupmode=3D"layer"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:label=3D"Image"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"g2025">
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect34"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"208.83351"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"486.09872"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"0.90158081"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"132.77872" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1019"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"188.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1021"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"346.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1103"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"266.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1105"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"426.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1107"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"506.06934" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.61883,171.88069 c 0.=
025,10.97895 0.01,1001.03791
> > > 0.049,1012.01891 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-1000.84096 -0.031,-1011.72348
> > > 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path381056"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1131"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"239.47592"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"1015.9909"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.65631"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"82.399658" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.27861;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1133"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"340.44653"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"525.77448"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.79562"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1142.5299" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1237"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"284.00113"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"945.41412"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"827.75012"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"82.880798"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1239"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"239.37569"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"179.03308"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.9507"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"98.758331" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.00744;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1241"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"239.4184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"713.64905"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.9543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"307.7951"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1345"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"330.32059"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"409.44757"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1363.8723"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1147.7572" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1347"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"369.8941"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"682.32245"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"825.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1146.6448"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1349"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"163.95746"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"40.144867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1389.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"190.80583" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:0.964132;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1619"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"271.99091"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"42.038273"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1393.981"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1197.161"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1469.3028,1238.8328 c 0.=
025,10.9789 0.01,175.0378
> > > 0.049,186.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-174.8409 -0.031,-185.7234
> > > 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path106-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 407.4759,1238.4728 c 0.0=
25,10.9789 0.01,291.0378
> > > 0.049,302.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-290.8409 -0.031,-301.7234
> > > 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path106-1-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1623"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"137.32646"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.782684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1396.3848"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1268.2837"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1705"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"137.32646"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.782684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1396.3848"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1348.2837" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1707"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"137.32646"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.782684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1396.3848"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1432.2837" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1731"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"190.42665"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1813"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"254.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1815"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"318.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"412.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"560.42664" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1821"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"674.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"744.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1825"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"820.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1827"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"890.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1829"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"956.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1831"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1256.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1833"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1402.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1915"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1330.4268"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1917"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1478.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1919"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1548.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1921"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1614.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1923"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1686.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1925"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1754.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1925-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"134.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1954"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"276.37756"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.87333333;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1956"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"168.66573"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"122.14091"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.50134"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"358.6615"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1958"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"672.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1960"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"744.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.965912;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1962"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.14041"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"54.756817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.26404"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"814.42413"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.965912;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1964"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.14041"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"54.756817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.26404"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"886.42413"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.965912;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1966"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.14041"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"54.756817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.26404"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"952.42413"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:1.02091;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2428"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.0854"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"61.19017"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.29156"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1468.4518" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.839627;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2430"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.26669"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.344128"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.20093"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1550.3611" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.13491;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2432"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"287.86237"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.416805"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.34854"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5088" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.13102;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2434"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"285.86655"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.4207"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.34656"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5068" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2509" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2511" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2513" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2515" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2517" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2519" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2521" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2523" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2525" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2527" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2529" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2531" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 442.80064,179.02883 0.91=
401,36.01283 423.64827,-2.29193"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path6876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1925-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1731"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.45103,156.71704 205.=
18886,-0.43622 0.59548,162.1112
> > > 167.12755,0.0346"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path6878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1925-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 447.83425,321.05653 v 19=
=2E69319 h 419.52867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7294"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1954"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1815"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.45103,298.71704 H 65=
9.10058 V 434.74972 H 867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1954"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,560.42664 -422=
=2E77356,1.33638 0.45008,-79.26417"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7720"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.45103,696.74972 H 86=
7.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7726"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1958"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1821" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 867.36292,766.74972 H 49=
4.45103"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7728"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1960" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.45105,789.05652 H 65=
7.82418 V 1278.7498 H 867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7730"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1831"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.40445,841.80254 h 16=
7.41973 v 0.94718 h 205.53874"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8140"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1962"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1825" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.40445,913.80254 h 16=
7.41973 v -1.05282 h 205.53874"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8142"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1964"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1827" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.40445,979.80254 h 16=
7.41973 v -1.05282 h 205.53874"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8144"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1966"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1829" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.37697,1500.7498 H 86=
7.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8150"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2428"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1917" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.46762,1570.7498 h 37=
2.8953"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8152"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2430"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1919" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 1396.3848,1289.175 H 128=
8.1445 V 582.74972 h -198.4368"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8154"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1623"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1819" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1396.3848,1369.175 -159.=
2837,-1.364 0.5816,-88.2579
> > > -147.975,-0.8033"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8462"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1705"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1831"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1089.7077,1500.7498 h 37=
5.3403 v -26.6834"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8668"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1917"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1707" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 1389.9988,212.74973 H 10=
89.7077"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1349"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1731" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 1389.9988,230.9507 H 122=
3.331 v 109.79902 h -133.6233"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8674"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1815"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:40px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"58.63356"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"69.574417"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text28675"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan28673"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"58.63356"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"69.574417" /><=
/text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"56.388252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"221.86568"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text31913"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan31911"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"56.388252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"221.86568">Mat=
rix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"300.866"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text38843"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan38841"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"300.866">1D LU=
T</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"378.866"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text41049"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan41047"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"378.866">3D LU=
T</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"40.831493"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"460.87411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text45037"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan45035"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"40.831493"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"460.87411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Unpacking</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"62.130371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"540.68872"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text49945"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan49943"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"62.130371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"540.68872"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Other</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1423.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"128.08769"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text55719"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan55717"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1423.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"128.08769"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">drm_framebuffer</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1439.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text62479"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan62477"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1439.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">format</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1475.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"340.08771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64465"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64463"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1475.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"340.08771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">drm_plane</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1589.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1178.0876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1589.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1178.0876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">drm_crtc</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"872.23993"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1172.4491"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"872.23993"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1172.4491"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Stream</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"328.26071"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1175.6371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-2"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
8"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"328.26071"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1175.6371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">MPC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"330.14737"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"114.41869"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"330.14737"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"114.41869"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DPP</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1488.3608,401.47792 c 0.=
025,10.97895 0.01,773.03788
> > > 0.049,784.01888 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-772.84093 -0.031,-783.72345
> > > 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path106"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1495.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78849"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78847"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1495.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blender</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1417.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1294.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78853"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78851"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1417.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1294.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Degamma</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1451.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1376.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78857"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78855"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1451.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1376.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">CTM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1458.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78861"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78859"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1458.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Gamma</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"949.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104653"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104651"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"949.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">format</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"911.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"284.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104657"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104655"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"911.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"284.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">bias_and_scale</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"887.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"346.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104661"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104659"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"887.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"346.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">color space matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"871.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"442.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104665"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104663"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"871.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"442.74973"
> > > +
> > > style=3D"font-size:18.6667px">input_csc_color_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"905.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"586.74976"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text125075"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan125073"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"905.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"586.74976"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">in_transfer_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.0083"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"702.85938"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.0083"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"702.85938"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">hdr_mult</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"874.5556"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"773.42615"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-6"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"874.5556"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"773.42615"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">gamut_remap_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"913.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"846.55896"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-5"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"913.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"846.55896"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">in_shaper_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"937.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"918.25787"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-56"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"937.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"918.25787"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">lut3d_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.9895"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"986.10767"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.9895"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"986.10767"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">blend_tf</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"975.91803"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.5564"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"975.91803"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.5564"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blender</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"879.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1283.4249"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-2"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"879.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1283.4249"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">gamut_remap_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"925.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1359.2747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-0"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-9"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"925.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1359.2747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">func_shaper</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"930.33252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1430.2566"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-3"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"930.33252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1430.2566"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">lut3d_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"900.18158"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1504.6725"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-06"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"900.18158"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1504.6725"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">out_transfer_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"904.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.8053"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-6"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"904.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.8053"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">csc_color_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"903.16278"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1642.1078"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-8"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-7=
9"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"903.16278"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1642.1078"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">bit_depth_param</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"939.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1713.8068"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-20"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-2=
3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"939.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1713.8068"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">clamping</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"894.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1782.5244"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-7"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-5"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"894.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1782.5244"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">output_color_space</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"869.63062"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"117.7968"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"869.63062"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"117.7968"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Plane</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"27.605465"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"162.20587"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-2"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"27.605465"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"162.20587"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Legend</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.63959"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.293999"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.63959"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.293999"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DCN 2.0</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"826.65735"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-66"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"826.65735"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DC Interface</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1362.9948"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-95"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-0=
4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1362.9948"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DRM Interface</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:40px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.34656"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5068"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text184728"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan184726"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.34656"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5068" /><=
/text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"389.01593"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"159.8909"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-3"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"389.01593"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"159.8909"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">CNVC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"365.88379"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"303.59048"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-1"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"365.88379"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"303.59048"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Input CSC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"409.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"404.95001"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-93"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"409.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"404.95001"
> > > +         style=3D"font-size:18.6667px;text-align:center;text-anchor:=
middle">DeGamma</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"409.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"428.28339"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan233797">=
RAM and ROM</tspan><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"409.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"451.61676"
> > > +
> > > style=3D"font-size:10.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan242597">=
(sRGB, BT2020</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"351.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"700.34918"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-0"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"351.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"700.34918"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">HDR Multiply</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"345.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"771.33112"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-6"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
10"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"345.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"771.33112"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Gamut Remap</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"412.5184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"836.04877"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-63"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
20"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"412.5184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"836.04877"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle">Sh=
aper
> > > LUT</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"412.5184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"859.38214"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan222533">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.54086"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"908.61554"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-61"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
55"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.54086"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"908.61554"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle">3D
> > > LUT</tspan><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.54086"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"931.94891"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan221121">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"344.0347"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"985.33319"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-47"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
65"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"344.0347"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"985.33319"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blend Gamma</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"433.84625"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1223.411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-69"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
37"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"433.84625"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1223.411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blender</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.64996"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1492.8102"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-8"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
84"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.64996"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1492.8102"
> > > +         style=3D"font-size:18.6667px;text-align:center;text-anchor:=
middle">Gamma</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.64996"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1516.1436"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan197733">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"385.46863"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.2261"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-31"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
49"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"385.46863"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.2261"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">OCSC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:40px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.5106"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"53.140579"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text273287"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan273285"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.5106"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"53.140579" /><=
/text>
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"177.28049"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"38.940468"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1392.2576"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"459.24118" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1411.7203"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"485.93231"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78841"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78839"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1411.7203"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"485.93231"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">color_encoding</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1515"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"175.11876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"43.239407"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1393.7493"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"525.6983" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:17.33=
33px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1399.212"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"553.44904"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78845"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78843"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1399.212"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"553.44904">pix=
el_blend_mode</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect371322"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"177.28049"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"38.940468"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1391.6781"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"385.61713" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.5771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"409.29523"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78837"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78835"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.5771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"409.29523"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">color_range</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1469.6815,1334.9145 c 3.=
2597,-1.4841 6.4827,-3.0444
> > > 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025
> > > 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1467.8882,1256.0056 c 3.=
2597,-1.4841 6.4827,-3.0443
> > > 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3482 -10.7354,-18.5315 3.3569,1.5025
> > > 6.685,3.0628 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1487.6154,441.80981 c 3.=
2597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1489.4088,515.3385 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-22"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 400.8254,264.26491 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,346.76052 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,658.80913 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-5"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,732.33782 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-9"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.4121,800.48637 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.2055,875.80845 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-90"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 400.4121,942.16362 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-91"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 407.9989,1458.6579 c 3.2=
597,-1.4841 6.4827,-3.0444
> > > 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025
> > > 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-59"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0 </g>
> > > +</svg>
> > > diff --git
> > > a/Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
> > > b/Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
> > > new file mode 100644
> > > index 000000000000..7299ee9b6d64
> > > --- /dev/null
> > > +++ b/Documentation/gpu/amdgpu/display/dcn3_cm_drm_current.svg
> > > @@ -0,0 +1,1529 @@
> > > +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> > > +<!-- Created with Inkscape (http://www.inkscape.org/ -->
> > > +
> > > +<svg
> > > +=C2=A0=C2=A0 version=3D"1.1"
> > > +=C2=A0=C2=A0 id=3D"svg2019"
> > > +=C2=A0=C2=A0 width=3D"1702"
> > > +=C2=A0=C2=A0 height=3D"1845"
> > > +=C2=A0=C2=A0 viewBox=3D"0 0 1702 1845"
> > > +=C2=A0=C2=A0 sodipodi:docname=3D"dcn3_cm_drm_current.svg"
> > > +=C2=A0=C2=A0 inkscape:version=3D"1.1.2 (0a00cf5339, 2022-02-04)"
> > > +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape
> > >=20
> > > +
> > > xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd
> > >=20
> > > +   xmlns=3D"http://www.w3.org/2000/svg
> > >=20
> > > +   xmlns:svg=3D"http://www.w3.org/2000/svg
> > >=20
> > > +=C2=A0 <defs
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"defs2023" />
> > > +=C2=A0 <sodipodi:namedview
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"namedview2021"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 pagecolor=3D"#ffffff"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 bordercolor=3D"#666666"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 borderopacity=3D"1.0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:pageshadow=3D"2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:pageopacity=3D"0.0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:pagecheckerboard=3D"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 showgrid=3D"false"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:zoom=3D"0.55760543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:cx=3D"1011.4679"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:cy=3D"249.28021"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-width=3D"1920"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-height=3D"1011"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-x=3D"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-y=3D"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:window-maximized=3D"1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:current-layer=3D"g2025" />
> > > +=C2=A0 <g
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:groupmode=3D"layer"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:label=3D"Image"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"g2025">
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect34"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"208.83351"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"486.09872"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"0.90158081"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"132.77872" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1019"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"188.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1021"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"346.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1103"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"266.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1105"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"426.06937" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1107"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"126.38867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"55.320732"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"25.960823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"506.06934" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.61883,171.88069 c 0.=
025,10.97895 0.01,1001.03791
> > > 0.049,1012.01891 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-1000.84096 -0.031,-1011.72348
> > > 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path381056"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1131"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"239.47592"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"1015.9909"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.65631"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"82.399658" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.27861;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1133"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"340.44653"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"525.77448"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.79562"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1142.5299" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1237"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"284.00113"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"945.41412"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"827.75012"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"82.880798"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1239"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"239.37569"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"179.03308"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.9507"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"98.758331" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.00744;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1241"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"239.4184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"713.64905"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.9543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"307.7951"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1345"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"330.32059"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"409.44757"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1363.8723"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1147.7572" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1347"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"369.8941"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"682.32245"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"825.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1146.6448"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1349"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"163.95746"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"40.144867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1389.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"190.80583" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:0.964132;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1619"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"271.99091"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"42.038273"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1393.981"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1197.161"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1469.3028,1238.8328 c 0.=
025,10.9789 0.01,175.0378
> > > 0.049,186.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-174.8409 -0.031,-185.7234
> > > 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path106-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 407.4759,1238.4728 c 0.0=
25,10.9789 0.01,291.0378
> > > 0.049,302.0188 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-290.8409 -0.031,-301.7234
> > > 0.053,-0.3037 -0.2175,-0.5027 -0.3652,-0.7284 l 1.5347,0.394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path106-1-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1623"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"137.32646"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.782684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1396.3848"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1268.2837"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1705"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"137.32646"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.782684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1396.3848"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1348.2837" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1707"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"137.32646"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.782684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1396.3848"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1432.2837" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1731"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"190.42665"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1813"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"254.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1815"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"318.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"412.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"560.42664" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1821"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"674.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"744.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1825"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"820.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1827"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"890.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1829"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"956.42664"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1831"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1256.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1833"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1402.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1915"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1330.4268"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1917"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1478.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1919"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1548.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1921"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1614.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1923"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1686.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#eeeeee;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1925"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"222.34483"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.64616"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1754.4268" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1925-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"134.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1954"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"276.37756"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.87333333;stroke-opacity:1;stroke-miterlimit:4;stroke-dasharray:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1956"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"168.66573"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"122.14091"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.50134"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"358.6615"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#e6e6e6;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1958"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"672.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1960"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"744.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.965912;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1962"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.14041"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"54.756817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.26404"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"814.42413"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.965912;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1964"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.14041"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"54.756817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.26404"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"886.42413"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.965912;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1966"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.14041"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"54.756817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.26404"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"952.42413"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2418"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"510.37756"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-avoid=3D"tru=
e" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2422"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1262.3777" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.981369;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2424"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.12494"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"56.528603"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.27179"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1322.432" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#d0cee2;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.981369;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2426"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.12494"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"56.528603"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.27179"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1396.432" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:1.02091;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2428"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.0854"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"61.19017"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.29156"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1468.4518" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#fad7ac;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.839627;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2430"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.26669"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"41.344128"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.20093"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1550.3611" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.13491;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2432"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"287.86237"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.416805"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.34854"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5088" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#000000;fill-opacity:0;stroke:#000000;stroke-wi=
dth:1.13102;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2434"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"285.86655"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.4207"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.34656"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5068" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2509" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2511" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2513" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2515" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2517" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2519" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2521" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2523" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2525" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2527" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2529" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;stroke:#000000;stroke-width:2.66666675;str=
oke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;stroke-miterlimit:4=
;stroke-dasharray:8.00000024,
> > > 8.00000024;stroke-dashoffset:0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 867.36292,235.07281 v 0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path2531" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 449.83425,179.05653 v 33=
=2E6932 h 417.52867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path6876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1925-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1731"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.45103,156.71704 h 21=
6.64955 v 161.7096 h 156.26234"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path6878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1925-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 451.83425,321.05653 v 19=
=2E69319 h 415.52867"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7294"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1954"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1815"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.45103,298.71704 H 65=
9.10058 V 434.74972 H 867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1817"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1954"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 867.36292,560.42664 H 66=
1.10058 V 480.8024 H 494.16705"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7720"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 455.83425,594.37756 V 58=
2.74972 H 867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7724"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2420"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccc" />
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +       style=3D"fill:#afdde9;fill-opacity:1;stroke:#000000;stroke-wi=
dth:0.872749;stroke-opacity:1"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect2420"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"169.23357"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"44.678963"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"325.21747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"594.37756" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.45103,696.74972 H 86=
7.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7726"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1958"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1821" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 867.36292,766.74972 H 49=
4.45103"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7728"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1823"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1960" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.45105,789.05652 H 65=
7.82418 V 1278.7498 H 867.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path7730"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1831"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.40445,841.80254 h 16=
7.41973 v 0.94718 h 205.53874"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8140"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1962"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1825" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.40445,913.80254 h 16=
7.41973 v -1.05282 h 205.53874"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8142"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1964"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1827" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.40445,979.80254 h 16=
7.41973 v -1.05282 h 205.53874"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8144"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1966"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1829" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.39673,1352.7498 H 86=
7.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8146"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2424"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1915" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.39673,1424.7498 H 86=
7.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8148"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2426"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1833" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 494.37697,1500.7498 H 86=
7.36292"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8150"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2428"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1917" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 494.46762,1570.7498 h 37=
2.8953"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8152"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect2430"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1919" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 1396.3848,1289.175 H 128=
8.1445 V 582.74972 h -198.4368"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8154"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1623"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1819" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1396.3848,1369.175 h -15=
6.2403 v -90.4252 h -150.4368"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8462"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1705"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1831"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1089.7077,1500.7498 h 37=
5.3403 v -26.6834"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8668"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1917"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1707" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"fill:none;fill-rule:evenodd;stroke:#000000;stroke-wi=
dth:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-=
dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 1389.9988,212.74973 H 10=
89.7077"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-start=3D"#r=
ect1349"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1731" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +       style=3D"display:inline;fill:none;fill-rule:evenodd;stroke:#0=
00000;stroke-width:2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miter=
limit:4;stroke-dasharray:6,
> > > 6;stroke-dashoffset:0;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"M 1389.9988,230.9507 H 122=
3.331 v 109.79902 h -133.6233"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path8674"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-type=3D"orth=
ogonal"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connector-curvature=3D=
"0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:connection-end=3D"#rec=
t1815"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccc" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:40px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"58.63356"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"69.574417"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text28675"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan28673"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"58.63356"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"69.574417" /><=
/text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"56.388252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"221.86568"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text31913"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan31911"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"56.388252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"221.86568">Mat=
rix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"300.866"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text38843"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan38841"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"300.866">1D LU=
T</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"378.866"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text41049"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan41047"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"53.441296"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"378.866">3D LU=
T</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"40.831493"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"460.87411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text45037"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan45035"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"40.831493"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"460.87411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Unpacking</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"62.130371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"540.68872"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text49945"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan49943"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"62.130371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"540.68872"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Other</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1423.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"128.08769"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text55719"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan55717"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1423.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"128.08769"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">drm_framebuffer</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1439.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text62479"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan62477"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1439.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">format</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1475.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"340.08771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64465"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64463"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1475.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"340.08771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">drm_plane</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1589.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1178.0876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1589.2806"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1178.0876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">drm_crtc</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"872.23993"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1172.4491"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"872.23993"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1172.4491"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Stream</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"328.26071"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1175.6371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-2"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
8"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"328.26071"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1175.6371"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">MPC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"330.14737"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"114.41869"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"330.14737"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"114.41869"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DPP</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1488.3608,401.47792 c 0.=
025,10.97895 0.01,773.03788
> > > 0.049,784.01888 2.5462,-1.1592 5.0637,-2.3779 7.6202,-3.5187
> > > -2.7411,4.8298 -5.4987,9.6453 -8.2624,14.4607 -2.7925,-4.8257
> > > -5.5993,-9.6453 -8.3856,-14.4751 2.6221,1.1736 5.2217,2.3923
> > > 7.8398,3.5721 0,-10.8825 -0.035,-772.84093 -0.031,-783.72345
> > > 0.053,-0.30366 -0.2175,-0.50268 -0.3652,-0.72837 l 1.5347,0.39394 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path106"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"ccccccccc=
c"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.205176"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-325.50819"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-121.97185" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1495.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78849"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78847"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1495.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blender</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1417.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1294.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78853"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78851"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1417.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1294.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Degamma</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1451.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1376.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78857"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78855"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1451.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1376.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">CTM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1458.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78861"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78859"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.9988"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1458.7498"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Gamma</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"949.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104653"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104651"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"949.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"218.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">format</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"911.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"284.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104657"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104655"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"911.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"284.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">bias_and_scale</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"887.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"346.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104661"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104659"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"887.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"346.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">color space matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"871.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"442.74973"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text104665"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan104663"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"871.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"442.74973"
> > > +
> > > style=3D"font-size:18.6667px">input_csc_color_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"905.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"586.74976"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text125075"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan125073"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"905.99878"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"586.74976"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">in_transfer_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.0083"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"702.85938"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.0083"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"702.85938"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">hdr_mult</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"874.5556"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"773.42615"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-6"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"874.5556"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"773.42615"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">gamut_remap_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"913.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"846.55896"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-5"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"913.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"846.55896"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">in_shaper_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"937.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"918.25787"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-56"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"937.72528"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"918.25787"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">lut3d_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.9895"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"986.10767"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text117309-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan117307-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"945.9895"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"986.10767"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">blend_tf</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"975.91803"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.5564"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"975.91803"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1224.5564"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blender</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"879.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1283.4249"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-2"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"879.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1283.4249"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">gamut_remap_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"925.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1359.2747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-0"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-9"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"925.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1359.2747"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">func_shaper</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"930.33252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1430.2566"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-3"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"930.33252"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1430.2566"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">lut3d_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"900.18158"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1504.6725"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-06"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"900.18158"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1504.6725"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">out_transfer_func</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"904.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.8053"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-6"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"904.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.8053"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">csc_color_matrix</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"903.16278"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1642.1078"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-8"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-7=
9"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"903.16278"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1642.1078"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">bit_depth_param</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"939.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1713.8068"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-20"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-2=
3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"939.31372"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1713.8068"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">clamping</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"894.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1782.5244"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text137434-7"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan137432-5"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"894.0307"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1782.5244"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">output_color_space</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"869.63062"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"117.7968"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"869.63062"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"117.7968"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Plane</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"27.605465"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"162.20587"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-2"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"27.605465"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"162.20587"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Legend</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.63959"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.293999"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-9"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"298.63959"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.293999"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DCN 3.0</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"826.65735"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-66"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"826.65735"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DC Interface</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1362.9948"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text176429-95"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan176427-0=
4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1362.9948"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"59.458061"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">DRM Interface</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:40px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.34656"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5068"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text184728"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan184726"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"867.34656"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1194.5068" /><=
/text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"389.01593"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"159.8909"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-3"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"389.01593"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"159.8909"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">CNVC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"365.88379"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"303.59048"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-1"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"365.88379"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"303.59048"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Input CSC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"390.95001"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-93"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"390.95001"
> > > +         style=3D"font-size:18.6667px;text-align:center;text-anchor:=
middle">DeGamma</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"414.28339"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan233797">=
ROM</tspan><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"437.61676"
> > > +
> > > style=3D"font-size:10.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan233799">=
(sRGB, BT2020, Gamma 2.2,</tspan><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.06488"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"460.95013"
> > > +
> > > style=3D"font-size:10.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan242597">=
PQ, HLG)</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"372.44986"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"538.83807"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-94"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
78"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"372.44986"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"538.83807"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Post CSC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:16px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"335.31775"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"622.23511"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-4"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
5"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"335.31775"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"622.23511"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
16px">Gamma Correction</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"351.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"700.34918"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-0"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
3"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"351.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"700.34918"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">HDR Multiply</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"345.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"771.33112"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-6"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
10"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"345.16684"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"771.33112"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Gamut Remap</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"412.5184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"836.04877"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-63"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
20"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"412.5184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"836.04877"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle">Sh=
aper
> > > LUT</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"412.5184"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"859.38214"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan222533">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.54086"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"908.61554"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-61"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
55"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.54086"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"908.61554"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle">3D
> > > LUT</tspan><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"413.54086"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"931.94891"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan221121">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"344.0347"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"985.33319"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-47"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
65"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"344.0347"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"985.33319"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blend Gamma</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"433.84625"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1223.411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-69"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
37"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"433.84625"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1223.411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Blender</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"343.73291"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1290.2421"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-45"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
25"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"343.73291"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1290.2421"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">Gamut Remap</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.74442"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1344.2428"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-474"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.74442"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1344.2428"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle">Sh=
aper
> > > LUT</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.74442"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1367.5762"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan208303">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"407.1257"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1420.2435"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-30"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
786"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"407.1257"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1420.2435"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle">3D
> > > LUT</tspan><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"407.1257"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1443.5769"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan204749">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.64996"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1492.8102"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-8"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
84"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.64996"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1492.8102"
> > > +         style=3D"font-size:18.6667px;text-align:center;text-anchor:=
middle">Gamma</tspan><tspan
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"408.64996"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1516.1436"
> > > +
> > > style=3D"font-size:18.6667px;text-align:center;text-anchor:middle"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan197733">=
RAM</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"385.46863"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.2261"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text64469-9-31"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan64467-2-=
49"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"385.46863"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"1575.2261"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">OCSC</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:40px;=
line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;stroke:=
none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.5106"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"53.140579"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text273287"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan273285"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1356.5106"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"53.140579" /><=
/text>
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1411"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"177.28049"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"38.940468"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1392.2576"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"459.24118" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1411.7203"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"485.93231"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78841"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78839"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1411.7203"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"485.93231"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">color_encoding</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect1515"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"175.11876"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"43.239407"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1393.7493"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"525.6983" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:17.33=
33px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1399.212"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"553.44904"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78845"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78843"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1399.212"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"553.44904">pix=
el_blend_mode</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <rect
> > > +
> > > style=3D"fill:#f9f7ed;fill-opacity:1;stroke:#000000;stroke-opacity:1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"rect371322"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 width=3D"177.28049"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 height=3D"38.940468"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1391.6781"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"385.61713" />
> > > +=C2=A0=C2=A0=C2=A0 <text
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xml:space=3D"preserve"
> > > +       style=3D"font-style:normal;font-weight:normal;font-size:18.66=
67px;line-height:1.25;font-family:sans-serif;fill:#000000;fill-opacity:1;st=
roke:none"
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.5771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"409.29523"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"text78837"><tspan
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:role=3D"li=
ne"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"tspan78835"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=3D"1427.5771"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y=3D"409.29523"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"font-size:=
18.6667px">color_range</tspan></text>
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1469.6815,1334.9145 c 3.=
2597,-1.4841 6.4827,-3.0444
> > > 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025
> > > 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1467.8882,1256.0056 c 3.=
2597,-1.4841 6.4827,-3.0443
> > > 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3482 -10.7354,-18.5315 3.3569,1.5025
> > > 6.685,3.0628 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-2"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1487.6154,441.80981 c 3.=
2597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-7"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 1489.4088,515.3385 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-22"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 400.8254,264.26491 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-6"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,346.76052 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-1"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 404.2055,500.78482 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-0"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,581.69367 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-61"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,658.80913 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-5"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.6188,732.33782 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-9"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.4121,800.48637 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-4"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 402.2055,875.80845 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-90"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 400.4121,942.16362 c 3.2=
597,-1.48411 6.4827,-3.04435
> > > 9.7556,-4.50482 -3.5093,6.18331 -7.0396,12.34823 -10.5778,18.51307
> > > -3.575,-6.17798 -7.1683,-12.34815 -10.7354,-18.53146 3.3569,1.50251
> > > 6.685,3.06275 10.0367,4.57314 0,0 0,0 1.5209,-0.0499 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-91"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 407.9989,1311.6005 c 3.2=
597,-1.4841 6.4827,-3.0444
> > > 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.513
> > > -3.575,-6.1779 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025
> > > 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-77"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 407.9989,1381.5424 c 3.2=
597,-1.4841 6.4827,-3.0443
> > > 9.7556,-4.5048 -3.5093,6.1833 -7.0396,12.3482 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3482 -10.7354,-18.5315 3.3569,1.5025
> > > 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-11"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0=C2=A0=C2=A0 <path
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=3D"m 407.9989,1458.6579 c 3.2=
597,-1.4841 6.4827,-3.0444
> > > 9.7556,-4.5049 -3.5093,6.1834 -7.0396,12.3483 -10.5778,18.5131
> > > -3.575,-6.178 -7.1683,-12.3481 -10.7354,-18.5314 3.3569,1.5025
> > > 6.685,3.0627 10.0367,4.5731 0,0 0,0 1.5209,-0.05 z"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id=3D"path371636-7-59"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sodipodi:nodetypes=3D"cccccc"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 style=3D"stroke-width:0.262672"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-x=3D"=
-416.72543"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inkscape:transform-center-y=3D"=
-156.15191" />
> > > +=C2=A0 </g>
> > > +</svg>
> > > diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst
> > > b/Documentation/gpu/amdgpu/display/display-manager.rst
> > > index b1b0f11aed83..8960a5f1fa66 100644
> > > --- a/Documentation/gpu/amdgpu/display/display-manager.rst
> > > +++ b/Documentation/gpu/amdgpu/display/display-manager.rst
> > > @@ -49,3 +49,38 @@ Color Management Properties
> > > =C2=A0 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_d=
m_color.c
> > > =C2=A0=C2=A0=C2=A0=C2=A0 :internal:
> > > +
> > > +
> > > +DC Color Capabilities between DCN generations
> > > +---------------------------------------------
> > > +
> > > +DRM/KMS framework defines three CRTC color correction properties:
> > > degamma,
> > > +color transformation matrix (ctm) and gamma, and two properties for
> > > degamma and
> >=20
> > Abbreviations should be written as all-uppercase
> > https://docs.kernel.org/gpu/introduction.html?highlight=3Duppercase#sty=
le-guidelines
> >=20
> >=20
> > > +gamma lut sizes. AMD DC programs some of the color correction featur=
es
> > > +pre-blending but DRM/KMS has not per-plane color correction properti=
es.
> > > +
> > > +What's possible to do before and after blending has changed quite a
> > > bit between
> > > +DCN generations as it depends on hardware color capabilities. DPP
> > > and MPC color
> > > +correction caps are described below.
> > > +
> > > +.. kernel-doc:: drivers/gpu/drm/amd/display/dc/dc.h
> > > +=C2=A0=C2=A0 :doc: color-management-caps
> > > +
> > > +.. kernel-doc:: drivers/gpu/drm/amd/display/dc/dc.h
> > > +=C2=A0=C2=A0 :internal:
> > > +
> > > +In general, the DRM three properties are programed to DC, as
> > > follows: CRT > +gamma after blending, and CRTC degamma pre-blending.
> > > Although CTM is
> > programmed
> > > +after blending, it is mapped to DPP hw blocks (pre-blending). Other
> > > color caps
> > > +available in the hw is not currently exposed by DRM interface and ar=
e by
> > > +passed.=C2=A0 To illustrate DCN generation capabilities and differen=
ces
> > > between
> >=20
> > possible typo: "by\npassed" -> "bypassed"
> >=20
> > > +them, you can compare the color management schemas for DCN 2.0 and
> > > DCN 3.0
> > > +families below.
> > > +
> > > +**DCN 2.0 family color caps and mapping**
> > > +
> > > +.. kernel-figure:: dcn2_cm_drm_current.svg
> > > +
> > > +**DCN 3.0 family color caps and mapping**
> > > +
> > > +.. kernel-figure:: dcn3_cm_drm_current.svg
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> > > b/drivers/gpu/drm/amd/display/dc/dc.h
> > > index 7c42377f0aae..84275f3974c1 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dc.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> > > @@ -118,7 +118,26 @@ struct dc_plane_cap {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t min_height;
> > > =C2=A0 };
> > > -// Color management caps (DPP and MPC)
> > > +/**
> > > + * DOC: color-management-caps
> > > + *
> > > + * **Color management caps (DPP and MPC)**
> > > + *
> > > + * Modules/color calculates various colour operations which are
> > > translated to
> >=20
> > Nit: colour -> color
> > The DRM documentation has a **preference** for the american spelling ht=
tps://www.kernel.org/doc/html/latest/gpu/introduction.html?highlight=3DAmer=
ican%20English#style-guidelines
> >=20
> >=20
> > > + * abstracted HW. DCE 5-12 had almost no important changes, but
> > > starting with
> > > + * DCN1, every new generation comes with fairly major differences
> > > in color
> > > + * pipeline. Therefore, we abstract color pipe capabilities so
> > > modules/DM can
> > > + * decide mapping to HW block based on logical capabilities.
> > > + */
> > > +
> > > +/**
> > > + * struct rom_curve_caps - predefined transfer function caps for
> > > degamma and regamma
> > > + * @srgb: RGB color space transfer func
> > > + * @bt2020: BT.2020 transfer func
> > > + * @gamma2_2: standard gamma
> > > + * @pq: perceptual quantizer transfer function
> > > + * @hlg: hybrid log=E2=80=93gamma transfer function
> > > + */
> > > =C2=A0 struct rom_curve_caps {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t srgb : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t bt2020 : 1;
> > > @@ -127,36 +146,65 @@ struct rom_curve_caps {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t hlg : 1;
> > > =C2=A0 };
> > > +/**
> > > + * struct dpp_color_caps - color pipeline capabilities for display
> > > pipe and
> > > + * plane blocks
> > > + *
> > > + * @dcn_arch: all DCE generations treated the same
> > > + * @input_lut_shared: shared with DGAM. Input lut is different than
> > > most LUTs,
> > > + * just plain 256-entry lookup
> > > + * @icsc: input color space conversion
> >=20
> > ./drivers/gpu/drm/amd/display/dc/dc.h:181: warning: Function parameter
> > or member 'dgam_ram' not described in 'dpp_color_caps'
>=20
> Hi,
>=20
> I was trying to figure out the meaning of some of these fields.
>=20
>=20
> First of all, and in the LUT context, notice that some fields have the
> prefix _ram, and others have _rom. When you see the ram, it means that we
> have a hardware LUT in the device, and we can program its values. If you =
see
> rom, it also means that we have hardware LUT but have pre-hardcoded value=
s,
> which means that we can only select between a few of them (e.g., sRGB, PQ,
> etc.). I guess ROM is preferable since it requires less configuration.

Hi Siqueira,

Oh, thanks for describing the rom/ram differences (and sounds like a
analogy).

>=20
> >=20
> > > + * @post_csc: post color space conversion, before gamut remap
> > > + * @gamma_corr: degamma correction
> > > + * @hw_3d_lut: 3d lut support. It implies a shaper LUT before, it
> > > may be shared
> > > + * with MPC by setting mpc:shared_3d_lut flag
> > > + * @ogam_ram: blend gamma
>=20
> dgam refers to 'degamma'
>=20
> and
>=20
> ogam to 'out gamma'.
>=20
>=20
> > > + * @ocsc: output color space conversion
> >=20
> > ./drivers/gpu/drm/amd/display/dc/dc.h:181: warning: Function parameter
> > or member 'dgam_rom_for_yuv' not described in 'dpp_color_caps'
>=20
> dgam_rom_for_yuv -> I don't know precisely why we have this, but since DC=
N3
> introduced it, I guess this is a specific behavior to compute yuv.
>=20
> afaik, this caps stands for capabilities, i.e., dpp_color_caps describes =
the
> DPP color capabilities configured for the specific hardware and setup.

I'm preparing a v2 that includes your inputs.

Thanks again,

Melissa
>=20
> Best Regards
> Siqueira
>=20
> >=20
> > > + * @dgam_rom_caps: caps for degamma
> > > + * @ogam_rom_caps: caps for regamma 1D lut
> > > + *
> > > + * Note: hdr_mult and gamut remap (ctm) are always available in DPP
> > > (in that order)
> > > + */
> > > =C2=A0 struct dpp_color_caps {
> > > -=C2=A0=C2=A0=C2=A0 uint16_t dcn_arch : 1; // all DCE generations tre=
ated the same
> > > -=C2=A0=C2=A0=C2=A0 // input lut is different than most LUTs, just pl=
ain 256-entry
> > > lookup
> > > -=C2=A0=C2=A0=C2=A0 uint16_t input_lut_shared : 1; // shared with DGAM
> > > +=C2=A0=C2=A0=C2=A0 uint16_t dcn_arch : 1;
> > > +=C2=A0=C2=A0=C2=A0 uint16_t input_lut_shared : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t icsc : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t dgam_ram : 1;
> > > -=C2=A0=C2=A0=C2=A0 uint16_t post_csc : 1; // before gamut remap
> > > +=C2=A0=C2=A0=C2=A0 uint16_t post_csc : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t gamma_corr : 1;
> > > -
> > > -=C2=A0=C2=A0=C2=A0 // hdr_mult and gamut remap always available in D=
PP (in that order)
> > > -=C2=A0=C2=A0=C2=A0 // 3d lut implies shaper LUT,
> > > -=C2=A0=C2=A0=C2=A0 // it may be shared with MPC - check MPC:shared_3=
d_lut flag
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t hw_3d_lut : 1;
> > > -=C2=A0=C2=A0=C2=A0 uint16_t ogam_ram : 1; // blnd gam
> > > +=C2=A0=C2=A0=C2=A0 uint16_t ogam_ram : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ocsc : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t dgam_rom_for_yuv : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rom_curve_caps dgam_rom_caps;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rom_curve_caps ogam_rom_caps;
> > > =C2=A0 };
> > > +/**
> > > + * struct mpc_color_caps - color pipeline capabilities for multiple
> > > pipe and
> > > + * plane combined blocks
> > > + *
> > > + * @gamut_remap: color transformation matrix
> >=20
> > ./drivers/gpu/drm/amd/display/dc/dc.h:201: warning: Function parameter
> > or member 'ogam_ram' not described in 'mpc_color_caps'
> >=20
> > > + * @ocsc: output color space conversion matrix
> > > + * @num_3dluts: 3d lut, always assumes a preceding shaper LUT
> > > + * @shared_3d_lut: shared 3d lut flag, can be either DPP or MPC,
> > > but single
> > > + * instance
> > > + * @ogam_rom_caps: caps for regama 1d lut
> >=20
> > typo: regama -> regamma
> >=20
> > > + */
> > > =C2=A0 struct mpc_color_caps {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t gamut_remap : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ogam_ram : 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ocsc : 1;
> > > -=C2=A0=C2=A0=C2=A0 uint16_t num_3dluts : 3; //3d lut always assumes =
a preceding
> > > shaper LUT
> > > -=C2=A0=C2=A0=C2=A0 uint16_t shared_3d_lut:1; //can be in either DPP =
or MPC, but
> > > single instance
> > > -
> > > +=C2=A0=C2=A0=C2=A0 uint16_t num_3dluts : 3;
> > > +=C2=A0=C2=A0=C2=A0 uint16_t shared_3d_lut:1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rom_curve_caps ogam_rom_caps;
> > > =C2=A0 };
> > > +/**
> > > + * struct dc_color_caps - color pipes capabilities for DPP and MPC
> > > hw blocks
> > > + * @dpp: color pipes caps for DPP
> > > + * @mpc: color pipes caps for MPC
> > > + */
> > > =C2=A0 struct dc_color_caps {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dpp_color_caps dpp;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mpc_color_caps mpc;
> >=20
> >=20
> > Again, thanks for the documentation patch!
> >=20
> > Kind regards,
> > Tales Aparecida
>=20

--q4xbrqhrluimaryv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLih/QACgkQwqF3j0dL
ehxTjRAAxNMrG47t4c0QjCT92V+TRwbInSKgH4cT38EDF+q5xC08gsv7B5G77E5v
ZYxU8QKalSMgalsBv6bRsVwhzHEGFthanHJrjKaR2qpfNUNgK34n80Snq9JQNaCW
KX5QKhJj/axO8Mf2cgj+o2/Mqqvc4WPlRrleyLndqSN57ggBrYQOshJELTTiohPR
T+gt23c1PiqjyO9HWE5DP+U6vBB/NppeEMV8feG+VD/wYyxzpH/isRoG7vnf0IvY
sEof8/sl5LB1NGGA3EGs8ZGwNh+wivzqZ9inzdiBUFa5LRrL4gAdTP8mntG4uk4h
wg22Jj+H6Zn6/Nk3uMc3gDlHCCaAN0GS7mKga09UmYsY/3VF7KLYNtmq45EvWHhx
IcxrL8saeHe0wKYZX/EO8gAgUQCrJaJAFiLvtP1+Mfp+1PxoUybdCbO5a32VVz5a
PnAmaBNAfkSLzKVKVTyVoRQU3lb3x71eOrjOi1FRMb6Mw4IGNFJGP2drFPQiLvJ/
355WZHX+0Nvw4dHkSuEnbANWnrXaHdcZeiUkkTG2Q1azg+IDD3acIm9DhjGmD0rH
OAevjmF4pIi4le9eUBi5EqMDNRHx3I83WZzjJtwUMPANZJFkoXnu/IM/DegNFObY
G2BTk5LqQh3soNt7pHKWnFPjJWO6xlD+wzTFat2x883OZ4WT/50=
=5hA9
-----END PGP SIGNATURE-----

--q4xbrqhrluimaryv--
