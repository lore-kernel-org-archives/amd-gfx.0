Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A28CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 15:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE5A10E4ED;
	Mon, 25 Aug 2025 15:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPm46YWd";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD21E10E4E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:38:36 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-246190697f4so3958855ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756136316; x=1756741116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGUELbUnn/CwhxhI4DuCidS0/rxhNyeccuKVuEm19rE=;
 b=jPm46YWdAzYw8L0TFX9SZ+vkdGxvGUIB4jiiCQ3n07kEO6lo74rBBfoFFns6gzx/s4
 UILNR1x2fehlLN0JTJ3NHPLFRGKTbtz/sOOGYsA8YdfRhPCpAo15blThtv73kP+kW2Je
 IyWQVEvY3n2xtcTWrIldUaWotBQaL85g9jRlrFbjeSn5DTrkL1tNbCe8cWsCWHs+Z2FX
 5ncHYV9JP2k9nxciBmBNJxszCQX1zg7V8Cl0I1EqJXOQFv7hMobqknKdMbeBV8SckURG
 sAbtfrjVFT0SiuJpP1gno2cfnfMS+YnvrBQSR0ZT3vcJKsP0jgwGO8H6+QMSPEmHB31R
 RKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756136316; x=1756741116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGUELbUnn/CwhxhI4DuCidS0/rxhNyeccuKVuEm19rE=;
 b=D1gAvVGPUV3sLxIpqjRHOQHQVO3shC3KqVeDQUp3zb/xXCSLtxnAp5eAhOX3ER2/c5
 cYeEr11ZAe3KWQqKVhIQAloL6mvq6MCeznP1UN2O1eu2L/6YctJe42mUCG8qbS6n+eYu
 n3YRbUsEIJx+41dYSwB0UJOeU9saK9A7RosWTFMCBVfoEKv7nZqh9dWhurlexiR9w+aW
 a0aSRBM1V5PVj8rgpEzutvWROkFEwpglB/6155JcPhqsBs4gK5fElpFoLwL7io9vGyoe
 P9l8Pkzpitw/I97Ry4QH8p6rIdVqrqlViVE7zJoVtGjysf2SwY2EsRGiKrZOF/Qleg0t
 fNng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXcdfRMthdlOtiBET9Wt/7hoMFDfteTsfPbPkIoWQUqnNo/4kZhZ7alo5/Egsd0aODVLUw9YHL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiNzRdkZ4w+EAc+kALL/Jelx1e5GuKrG4C/xA053W+DknrXDwh
 tsXtd1+qOkJsUX9F9fOAIsOvZJYNKL1tjol1S9BADXKdAfE0ofneh/kgeNHVFjGYDNChazKhFxk
 hLQ3mdfw2GUOi6MYzM9U3C3Q8hLxcYcY=
X-Gm-Gg: ASbGncujHoSXQ5zoeQdZNFGGMAjAAvZy3EsQzrC0BAhHfbtjU52l6sb27u7twxnk1PJ
 PHKICDlPHnC8taJwmhURGoY1KBxHhW+sFjmrHgc0BtdnLAkHCx91/WO+SwXvo5gGnujz0OPXsS9
 vQ62hIBLQWDRdYtJXxC6O1CiGvavVYrQ4aYb4YDRZqv9WTPZSQ/RtLaPeHnPHj0CorQUZa3qW7E
 SEpPL8=
X-Google-Smtp-Source: AGHT+IGKQ0wbBTI2mNQZeVIT9tDHvx64jJf0aveh6GM8EFa/sHRWYPa9eLVHhGz69nhf+xurVXPSlQSnkJyZes4Zvb0=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr39261815ad.4.1756136316257; Mon, 25 Aug 2025
 08:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-5-siqueira@igalia.com>
In-Reply-To: <20250824233149.3780127-5-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 11:38:23 -0400
X-Gm-Features: Ac12FXz-1nE60ih1JMBzIgPLB8zQNtm1UrqQUZMS56Hu9p_X5kSoIb-HLG0xUSU
Message-ID: <CADnq5_PvQS-45bM7d2ZXKo4h_C+aS8FP5Qk-1qvBDdo9s-10kg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Sun, Aug 24, 2025 at 7:43=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> This commit introduces a diagram and a set of information that details
> the different sets of schedulers available in the SE.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  Documentation/gpu/amdgpu/gc/cu.svg    | 437 ++++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/gc/index.rst |  32 +-
>  2 files changed, 463 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/gpu/amdgpu/gc/cu.svg
>
> diff --git a/Documentation/gpu/amdgpu/gc/cu.svg b/Documentation/gpu/amdgp=
u/gc/cu.svg
> new file mode 100644
> index 000000000000..10bdb3e24b65
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/gc/cu.svg
> @@ -0,0 +1,437 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"411.03354mm"
> +   height=3D"213.48447mm"
> +   viewBox=3D"0 0 411.03354 213.48447"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname=3D"cu.svg"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns:xlink=3D"http://www.w3.org/1999/xlink"
> +   xmlns=3D"http://www.w3.org/2000/svg"
> +   xmlns:svg=3D"http://www.w3.org/2000/svg">
> +  <sodipodi:namedview
> +     id=3D"namedview1"
> +     pagecolor=3D"#ffffff"
> +     bordercolor=3D"#000000"
> +     borderopacity=3D"0.25"
> +     inkscape:showpageshadow=3D"2"
> +     inkscape:pageopacity=3D"0.0"
> +     inkscape:pagecheckerboard=3D"0"
> +     inkscape:deskcolor=3D"#d1d1d1"
> +     inkscape:document-units=3D"mm"
> +     inkscape:zoom=3D"1"
> +     inkscape:cx=3D"606.5"
> +     inkscape:cy=3D"161.5"
> +     inkscape:window-width=3D"3072"
> +     inkscape:window-height=3D"1651"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     inkscape:current-layer=3D"layer1"
> +     showguides=3D"false" />
> +  <defs
> +     id=3D"defs1">
> +    <symbol
> +       id=3D"AigaSymbols.svg:RightArrow">
> +      <title
> +         id=3D"title272">Right Arrow</title>
> +      <path
> +         d=3D"M 63,36 41,58 H 26 L 42,42 H 10 V 30 H 42 L 26,14 h 15 z"
> +         style=3D"stroke:none"
> +         id=3D"path272" />
> +    </symbol>
> +  </defs>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(-21.831087,-67.399327)">
> +    <rect
> +       style=3D"fill:#ffffff;stroke-width:1;stroke-dasharray:1, 1"
> +       id=3D"rect2"
> +       width=3D"413.01459"
> +       height=3D"215.10625"
> +       x=3D"21.037336"
> +       y=3D"67.39933"
> +       ry=3D"0" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke=
-dasharray:none"
> +       id=3D"rect1"
> +       width=3D"171.65263"
> +       height=3D"98.433296"
> +       x=3D"22.326748"
> +       y=3D"80.365692" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:4.9389px;font-family:'Linux Libertine O';-in=
kscape-font-specification:'Linux Libertine O';text-align:start;letter-spaci=
ng:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#00d40=
0;stroke:#00d400;stroke-width:1;stroke-dasharray:none"
> +       x=3D"45.418606"
> +       y=3D"231.96919"
> +       id=3D"text12"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan12"
> +         style=3D"stroke-width:1"
> +         x=3D"45.418606"
> +         y=3D"231.96919" /></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"220.24004"
> +       y=3D"72.225327"
> +       id=3D"text14-7"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"220.24004"
> +         y=3D"72.225327"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan14-7">Dual Compute Unite (CU)</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"88.634293"
> +       y=3D"100.9926"
> +       id=3D"text14-7-5"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"88.634293"
> +         y=3D"100.9926"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan21">Schedulers</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#aa0000;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect20"
> +       width=3D"165.53069"
> +       height=3D"21.603296"
> +       x=3D"26.396732"
> +       y=3D"87.214386" />
> +    <rect
> +       style=3D"fill:none;stroke:#008000;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect32"
> +       width=3D"72.816223"
> +       height=3D"59.460701"
> +       x=3D"119.51908"
> +       y=3D"111.4128" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"155.79736"
> +       y=3D"119.94101"
> +       id=3D"text32"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"155.79736"
> +         y=3D"119.94101"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan32">SGPR</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#00ccff;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect33"
> +       width=3D"72.123314"
> +       height=3D"12.543721"
> +       x=3D"34.27282"
> +       y=3D"126.84049" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"70.584946"
> +       y=3D"135.25613"
> +       id=3D"text33"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"70.584946"
> +         y=3D"135.25613"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan33">Float ALU</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect34"
> +       width=3D"72.123314"
> +       height=3D"12.543721"
> +       x=3D"34.27282"
> +       y=3D"141.15512" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"70.584946"
> +       y=3D"149.54356"
> +       id=3D"text34"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"70.584946"
> +         y=3D"149.54356"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan34">Integer ALU</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#536c53;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect35"
> +       width=3D"72.123314"
> +       height=3D"12.543721"
> +       x=3D"34.27282"
> +       y=3D"155.4696" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"70.711952"
> +       y=3D"163.18179"
> +       id=3D"text35"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"70.711952"
> +         y=3D"163.18179"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan35">Accelerators (e.g., AI)</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#aaffcc;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect36"
> +       width=3D"87.45388"
> +       height=3D"60.884953"
> +       x=3D"26.806004"
> +       y=3D"110.89911" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"70.532944"
> +       y=3D"119.94102"
> +       id=3D"text36"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"70.532944"
> +         y=3D"119.94102"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan36">VGPR</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#00ccff;stroke-width:1;stroke-dasharray=
:none;stroke-dashoffset:0"
> +       id=3D"rect37"
> +       width=3D"52.815948"
> +       height=3D"12.68323"
> +       x=3D"130.37912"
> +       y=3D"126.77074" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"156.77298"
> +       y=3D"135.22902"
> +       id=3D"text37"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"156.77298"
> +         y=3D"135.22902"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan38">Scalar Unit</tspan></text>
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#8080ff;stroke-width:1;stroke-dashar=
ray:none;stroke-dashoffset:0"
> +       id=3D"rect39"
> +       width=3D"23.488506"
> +       height=3D"199.71252"
> +       x=3D"196.07666"
> +       y=3D"80.442635" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"207.6935"
> +       y=3D"178.88779"
> +       id=3D"text39"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"207.6935"
> +         y=3D"178.88779"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan39">Scalar</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"207.6935"
> +         y=3D"185.94334"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan40">Cache</tspan></text>
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#8080ff;stroke-width:1;stroke-dashar=
ray:none;stroke-dashoffset:0"
> +       id=3D"rect40"
> +       width=3D"36.175877"
> +       height=3D"199.38167"
> +       x=3D"222.0493"
> +       y=3D"80.60807" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:5.64444px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"240.29651"
> +       y=3D"175.36002"
> +       id=3D"text42"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"240.29651"
> +         y=3D"175.36002"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan42">Shader</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"240.29651"
> +         y=3D"182.41557"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan43">Instruction</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"240.29651"
> +         y=3D"189.47112"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan44">Cache</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"117.62655"
> +       y=3D"86.0942"
> +       id=3D"text46"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"117.62655"
> +         y=3D"86.0942"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan46">Block #1</tspan></text>
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke=
-dasharray:none"
> +       id=3D"rect46"
> +       width=3D"171.65263"
> +       height=3D"98.433296"
> +       x=3D"22.326748"
> +       y=3D"181.95483" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"117.62655"
> +       y=3D"192.60635"
> +       id=3D"text47"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"117.62655"
> +         y=3D"192.60635"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan47">Block #2</tspan></text>
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke=
-dasharray:none"
> +       id=3D"rect47"
> +       width=3D"171.65263"
> +       height=3D"98.433296"
> +       x=3D"260.71634"
> +       y=3D"80.884003" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"356.01614"
> +       y=3D"91.535522"
> +       id=3D"text48"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"356.01614"
> +         y=3D"91.535522"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan48">Block #3</tspan></text>
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke=
-dasharray:none"
> +       id=3D"rect48"
> +       width=3D"171.65263"
> +       height=3D"98.433296"
> +       x=3D"260.71634"
> +       y=3D"181.16109" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"356.01614"
> +       y=3D"191.81261"
> +       id=3D"text49"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"356.01614"
> +         y=3D"191.81261"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan49">Block #4</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-size:5.64444px;font-family:'Linux Libertine O';-ink=
scape-font-specification:'Linux Libertine O';text-align:start;letter-spacin=
g:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;st=
roke:#8080ff;stroke-width:1"
> +       x=3D"178.00336"
> +       y=3D"42.984257"
> +       id=3D"text5"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan5"
> +         style=3D"stroke-width:1" /></text>
> +    <g
> +       id=3D"g8"
> +       transform=3D"translate(-14.022917,61.780208)">
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:5.64444=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"127.87695"
> +         y=3D"38.251671"
> +         id=3D"text1"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"127.87695"
> +           y=3D"38.251671"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan1">CP</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:5.64444=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#0000ff;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"151.68944"
> +         y=3D"34.369583"
> +         id=3D"text2"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"151.68944"
> +           y=3D"34.369583"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#0000ff;stroke-width:0.0690111"
> +           id=3D"tspan2">CPC</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:5.64444=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#008000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"151.68944"
> +         y=3D"41.990528"
> +         id=3D"text3"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"151.68944"
> +           y=3D"41.990528"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#008000;stroke-width:0.0690111"
> +           id=3D"tspan3">CPG</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:5.64444=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"169.2464"
> +         y=3D"37.757202"
> +         id=3D"text4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"169.2464"
> +           y=3D"37.757202"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.0690111"
> +           id=3D"tspan4">CPF</tspan></text>
> +      <use
> +         xlink:href=3D"#AigaSymbols.svg:RightArrow"
> +         style=3D"fill:#000000;stroke:#000000"
> +         id=3D"use1"
> +         transform=3D"matrix(0.11481918,0,0,0.11481918,134.58602,32.1031=
16)" />
> +      <rect
> +         style=3D"fill:none;stroke:#8080ff;stroke-width:0.5;stroke-dasha=
rray:none"
> +         id=3D"rect5"
> +         width=3D"33.919868"
> +         height=3D"16.754484"
> +         x=3D"142.33916"
> +         y=3D"27.961687" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:11.2889=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"161.22551"
> +         y=3D"39.187115"
> +         id=3D"text6"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"161.22551"
> +           y=3D"39.187115"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan6">}</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:22.5778=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"123.70975"
> +         y=3D"42.513233"
> +         id=3D"text7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"123.70975"
> +           y=3D"42.513233"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:22.5778px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan7">(</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:22.5778=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"-180.12157"
> +         y=3D"42.513233"
> +         id=3D"text8"
> +         transform=3D"scale(-1,1)"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-180.12157"
> +           y=3D"42.513233"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:22.5778px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan8">(</tspan></text>
> +    </g>
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/gc/index.rst b/Documentation/gpu/am=
dgpu/gc/index.rst
> index ff6e9ef5cbee..19f2ba53ee49 100644
> --- a/Documentation/gpu/amdgpu/gc/index.rst
> +++ b/Documentation/gpu/amdgpu/gc/index.rst
> @@ -10,16 +10,36 @@ producer-consumer problem, where the CPU fills out a =
buffer with operations
>  the buffer are called Command Packets, which can be summarized as a comp=
ressed
>  way of transmitting command information to the graphics controller.
>
> +In the diagram below, you can see an overview of the GC, along with addi=
tional
> +information about the Shader Engine (SE).
> +
> +.. kernel-figure:: cu.svg

Do you have a link to the images?

> +
> +First of all, note that the GC can have multiple SEs, depending on the s=
pecific
> +GPU/APU, and each SE has multiple Compute Units (CU). From the diagram, =
you can
> +see that CUs have a block named Schedulers. The reason the name is in pl=
ural is
> +because this hardware block is a combination of different micro-schedule=
s: CP,
> +CPF, CPC, and CPG.

CP is not really in the same category as CPF, CPC, CPG.  CP is the
front end to the GC block and contains a number of micro controllers
which run firmware which software interacts with.  CPF, CPG, and CPC
are just hardware implementation details.

> +
>  The component that acts as the front end between the CPU and the GPU is =
called
> -the Command Processor (CP). This component is responsible for providing =
greater
> +CP (Command Processor). This component is responsible for providing grea=
ter
>  flexibility to the GC since CP makes it possible to program various aspe=
cts of
>  the GPU pipeline. CP also coordinates the communication between the CPU =
and GPU
>  via a mechanism named **Ring Buffers**, where the CPU appends informatio=
n to
> -the buffer while the GPU removes operations. It is relevant to highlight=
 that a
> -CPU can add a pointer to the Ring Buffer that points to another region o=
f
> -memory outside the Ring Buffer, and CP can handle it; this mechanism is =
called
> -**Indirect Buffer (IB)**. CP receives and parses the Command Streams (CS=
), and
> -writes the operations to the correct hardware blocks.
> +the buffer while the GPU removes operations. Finally, CP is also respons=
ible
> +for handling Indirect Buffers (IB).
> +
> +After CP completes the first set of processing, which includes separate =
command
> +packets specific to GFX and Compute, other blocks step in. To handle com=
mands
> +for the compute block, CPC (Command Processor Command) takes over, and f=
or
> +handling Graphics operations, the CPG (Command Processor Graphics) takes
> +action. Another essential block to ensure the optimal utilization of CPC=
 and
> +CPG is the CPF (Command Processor Fetcher), which helps these blocks to =
be
> +constantly fed. Note that CPG contains the PFP (Pre-Fetch Parser), ME
> +(MicroEngine), and CE (Constant Engine) in the case of chips that suppor=
t it.
> +CPC contains MEC (MicroEngine Compute), and CPF is another hardware bloc=
k that
> +provides services to CPG and CPC.

I'm not sure how much value this provides to the average developer.
These are sort of implementation details of the hardware.  In general
the driver doesn't really interact with the individual hardware blocks
and they may not stay consistent over time.

Alex

> +
>
>  Graphics (GFX) and Compute Microcontrollers
>  -------------------------------------------
> --
> 2.47.2
>
