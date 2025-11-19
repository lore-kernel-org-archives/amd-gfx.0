Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9372FCF34B5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2648E10E63E;
	Wed, 19 Nov 2025 14:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQn/1E9j";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E764B10E63E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:27:29 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7a9fb70f7a9so368470b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763562449; x=1764167249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xuvod8grozZyVvuLaVOjVPASN9oRzOI7S73vkRtTyPI=;
 b=OQn/1E9jvaQFHO+oWlCJQaYJgGIU1WS3BocqPgK0Eggm0N6aHx4z9g0lq+FFfjkmMA
 3g3/xfXaouQb2Z8zdHBJCa+/Kr9TkOIcasD44h9OqnV3lfwBlJmK3VR+x0QI3OCq10Xo
 IwpMs4dq/1IDNnB5z+KvqEUhSxXUPL5d8c2T9Ou+mkuoqmwUje0GeC+ELjAP88mX/TNT
 Xu52aiLPzFT1eYV04kAqvRI7+qcg1u2IRe0utZ5KwgIuDPP3qDNsb+SZGYxqEPlt5/e5
 iOnauTdY/c6l+wNY6wcsiM6FMHw6VoFXPwECEbA8L5Q5L35+tpJ+AS5Zqp5422XuPJfU
 G7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763562449; x=1764167249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xuvod8grozZyVvuLaVOjVPASN9oRzOI7S73vkRtTyPI=;
 b=M3RBUpdInqLEi9axmPymbgSwYFI9zIzKWhcSYMXjBfleT3DtBDcW7DvpnWQN1tMnw5
 kqtX4gsyo0BjVXhJaUxh5P83qx6SFsDbFSBMz8bmctZjsnDNHQy4A9cEzTDzpej0OFGJ
 adS0ofpy3eSWha/UrYcrMFq9qZ5cZP4jda858hqJExXmsSHWzq8SG+UkdCdhtOqxKk/3
 VzwfDKPpRRpanjBpmXE9Ug2csEnjjgKXJsEfWagwnqzQMhY0AIpFD/ZqZWA6FBekNEAJ
 v5kyNm3OeqN0fAhkhOHiJ+RrsK0OrPV06E8mb9OAfxCBWR2a2O6wcu7elY7zigmuBIX4
 WHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOIh3cZL5EFUJSqo34uKp0otseCrnCzapKkCQVzmauxlS6xT+zbb1776IgI2+uW3hSrJLc+bvA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymlsdZ5wZzJblI1tYR1Xzz2TfATQSf3FyqoFKplOekuuwPrnKW
 M2jPsa9ChzP/ObcjH7834sy52ctDHeXVctQsx1rG4D4BFB10B3Wwu0RQ8m+A4E2CCS7jCd1PAbp
 lk2cFDnqF3vBKZmHKOP/IpzAqHYyAiM0=
X-Gm-Gg: ASbGnctpKQhRgriFVJJgubgfNTQvDXyZ0S/Ym/B/7CoN0IoyZMfQLqHiUY7DOpaXyQq
 Kqn5mRnz7Rzy8CDPsRa0AKxa0qW0hjoZW6L7rVKg5cJLblq5zrB3UdNoyWdz0SNj1rclCJr78po
 J912L9ZS5am6ZB9agjB7T5SXiw/cFUd/MweTwVGYecMaoznHSXP95NpvU8iqOjZDfq4wsfpHiPM
 NX53RLbgxMT9b9a2uRpYQWk/f82leGnpPXeh3pnv/QQvIw7zL7r6duZ1nmN+tOeqZzojEA=
X-Google-Smtp-Source: AGHT+IHSin4t5gPKaJ21u8rtU5DsZvxCkN2WBKC87v/muw/O0pF8XOcUUyFAkkryaNa037RVbSyk5U2F2XyV2mcRcyY=
X-Received: by 2002:a05:7022:61a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11b40b36d09mr8312280c88.0.1763562444683; Wed, 19 Nov 2025
 06:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20251119004818.4126460-1-siqueira@igalia.com>
 <20251119004818.4126460-4-siqueira@igalia.com>
In-Reply-To: <20251119004818.4126460-4-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Nov 2025 09:27:12 -0500
X-Gm-Features: AWmQ_bmAi7zYxoNNshNZYeYxnyOyRTwlsGbvAUiww-5zpK1mHZrgWQI6edaRNaU
Message-ID: <CADnq5_Pftx9p4NMWOE2nBtxeU+jOH6ht=fkC5dbiKn5KvHnp+w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] Documentation/gpu: Expand generic block information
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
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

Applied the series with one minor fix:
TMR =3D Trusted Memory Region

Thanks!

Alex

On Tue, Nov 18, 2025 at 7:48=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> This commit expands the overall explanation about AMD GPU IPs by adding
> more details about their interconnection. Note that this commit includes
> a diagram that provides additional information.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  .../gpu/amdgpu/amd_overview_block.svg         | 687 ++++++++++++++++++
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   9 +
>  .../gpu/amdgpu/display/dc-glossary.rst        |   3 -
>  Documentation/gpu/amdgpu/driver-core.rst      |  31 +
>  4 files changed, 727 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
>
> diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Documentat=
ion/gpu/amdgpu/amd_overview_block.svg
> new file mode 100644
> index 000000000000..cbd705afc9e2
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/amd_overview_block.svg
> @@ -0,0 +1,687 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"237.4014mm"
> +   height=3D"160.98259mm"
> +   viewBox=3D"0 0 237.4014 160.98259"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4.2 (ebf0e940d0, 2025-05-08)"
> +   sodipodi:docname=3D"amd_overview_block.svg"
> +   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
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
> +     inkscape:zoom=3D"2"
> +     inkscape:cx=3D"576.75"
> +     inkscape:cy=3D"313.25"
> +     inkscape:window-width=3D"3840"
> +     inkscape:window-height=3D"2083"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     inkscape:current-layer=3D"layer1" />
> +  <defs
> +     id=3D"defs1">
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"ArrowWideHeavy"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto-start-reverse"
> +       inkscape:stockid=3D"Wide, heavy arrow"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"m 1,0 -3,3 h -2 l 3,-3 -3,-3 h 2 z"
> +         id=3D"path3" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"ArrowWideRounded"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto-start-reverse"
> +       inkscape:stockid=3D"Wide, rounded arrow"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         style=3D"fill:none;stroke:context-stroke;stroke-width:1;stroke-=
linecap:round"
> +         d=3D"M 3,-3 0,0 3,3"
> +         transform=3D"rotate(180,0.125,0)"
> +         sodipodi:nodetypes=3D"ccc"
> +         id=3D"path2" />
> +    </marker>
> +  </defs>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(9.9255824,-64.69615)">
> +    <rect
> +       style=3D"fill:#ffffff;stroke:none;stroke-width:0.999747"
> +       id=3D"rect5"
> +       width=3D"239.13895"
> +       height=3D"162.38739"
> +       x=3D"-10.311751"
> +       y=3D"63.871342" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#000000;stroke-width:0.79375"
> +       id=3D"rect1"
> +       width=3D"174.55814"
> +       height=3D"140.23256"
> +       x=3D"22.263056"
> +       y=3D"65.093025" />
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect8-5"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"38.69939"
> +       y=3D"75.819946" />
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect9"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"176.7458"
> +       y=3D"75.68573" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-variant:normal;font-weight:normal=
;font-stretch:normal;font-size:4.9389px;font-family:'Linux Libertine O';-in=
kscape-font-specification:'Linux Libertine O';text-align:start;letter-spaci=
ng:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#00d40=
0;stroke:#00d400;stroke-width:1;stroke-dasharray:none"
> +       x=3D"45.418606"
> +       y=3D"216.62791"
> +       id=3D"text12"><tspan
> +         sodipodi:role=3D"line"
> +         id=3D"tspan12"
> +         style=3D"stroke-width:1"
> +         x=3D"45.418606"
> +         y=3D"216.62791" /></text>
> +    <g
> +       id=3D"g34">
> +      <rect
> +         style=3D"fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dash=
array:none"
> +         id=3D"rect7"
> +         width=3D"19.539951"
> +         height=3D"6.9818101"
> +         x=3D"22.811832"
> +         y=3D"210.3201" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"52.663685"
> +         y=3D"216.07796"
> +         id=3D"text68"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"52.663685"
> +           y=3D"216.07796"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#008033;stroke-width:0.0690111"
> +           id=3D"tspan68">UMC</tspan></text>
> +    </g>
> +    <g
> +       id=3D"g29"
> +       transform=3D"translate(-0.52916667)">
> +      <rect
> +         style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stro=
ke-dasharray:none"
> +         id=3D"rect8"
> +         width=3D"3.8659263"
> +         height=3D"4.2845292"
> +         x=3D"22.782616"
> +         y=3D"220.36148" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"48.966854"
> +         y=3D"224.15474"
> +         id=3D"text13"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"48.966854"
> +           y=3D"224.15474"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#00ff00;stroke-width:0.0690111"
> +           id=3D"tspan13">Memory hub</tspan></text>
> +    </g>
> +    <g
> +       id=3D"g12"
> +       transform=3D"translate(-1.8520837,2.3812496)">
> +      <g
> +         id=3D"g13">
> +        <rect
> +           style=3D"fill:#ffffff;stroke:#ffd42a;stroke-width:1;stroke-da=
sharray:none"
> +           id=3D"rect15"
> +           width=3D"28.674419"
> +           height=3D"11.302325"
> +           x=3D"114.87544"
> +           y=3D"169.54433"
> +           ry=3D"2.6458333" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:6.35p=
x;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0=
px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x=3D"129.06978"
> +           y=3D"177.46243"
> +           id=3D"text15"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"129.06978"
> +             y=3D"177.46243"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-=
font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;f=
ill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan15">PSP</tspan></text>
> +      </g>
> +    </g>
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 73.88372,201.92338 h 43.74419 V 184.5631"
> +       id=3D"path16"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#00ccff;stroke-width:1;stroke-dashar=
ray:none"
> +       id=3D"rect16"
> +       width=3D"40.220226"
> +       height=3D"11.1272"
> +       x=3D"150.82011"
> +       y=3D"193.07373" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"170.78101"
> +       y=3D"200.90428"
> +       id=3D"text16"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"170.78101"
> +         y=3D"200.90428"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan16">PCIe (NBIO)</tspan></text>
> +    <g
> +       id=3D"g10"
> +       transform=3D"translate(-8.807217,1.0583333)">
> +      <rect
> +         style=3D"fill:#ffffff;stroke:#ff6600;stroke-width:1;stroke-dash=
array:none"
> +         id=3D"rect10"
> +         width=3D"50.551014"
> +         height=3D"10.992874"
> +         x=3D"65.641136"
> +         y=3D"122.93423" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"91.040474"
> +         y=3D"130.69762"
> +         id=3D"text10"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"91.040474"
> +           y=3D"130.69762"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan10">SMU</tspan></text>
> +    </g>
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect14"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"171.61417"
> +       y=3D"125.16281" />
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect18"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"67.340591"
> +       y=3D"185.6201" />
> +    <g
> +       id=3D"g25"
> +       transform=3D"translate(165.76146,89.164578)">
> +      <g
> +         id=3D"g17"
> +         transform=3D"translate(-127.72192,-84.269792)">
> +        <rect
> +           style=3D"fill:#ffffff;stroke:#ff00ff;stroke-width:1;stroke-da=
sharray:none"
> +           id=3D"rect17"
> +           width=3D"50.551014"
> +           height=3D"10.992874"
> +           x=3D"83.42868"
> +           y=3D"140.39673" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:6.35p=
x;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0=
px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x=3D"108.55814"
> +           y=3D"148.16011"
> +           id=3D"text17"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"108.55814"
> +             y=3D"148.16011"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-=
font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;f=
ill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan17">SDMA</tspan></text>
> +      </g>
> +      <g
> +         id=3D"g24">
> +        <rect
> +           style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;st=
roke-dasharray:none"
> +           id=3D"rect21"
> +           width=3D"3.8659263"
> +           height=3D"4.2845292"
> +           x=3D"9.0765572"
> +           y=3D"57.429478" />
> +      </g>
> +    </g>
> +    <path
> +       style=3D"fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWideRounded)"
> +       d=3D"M 56.046208,126.07948 H 51.151416 V 110.60136"
> +       id=3D"path21"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray=
:1,1;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +       d=3D"m 107.63996,129.38677 h 31.91723"
> +       id=3D"path22" />
> +    <g
> +       id=3D"g26"
> +       transform=3D"translate(103.05521,-16.801041)">
> +      <path
> +         style=3D"fill:none;stroke:#ff6600;stroke-width:0.684499;stroke-=
dasharray:0.684499, 0.684499;stroke-dashoffset:0;marker-end:url(#ArrowWideH=
eavy)"
> +         d=3D"M 14.374335,237.26538 H 29.87027"
> +         id=3D"path23" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#ff6600;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"41.690811"
> +         y=3D"239.50058"
> +         id=3D"text23"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"41.690811"
> +           y=3D"239.50058"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#ff6600;stroke-width:0.0690111"
> +           id=3D"tspan23">Reset</tspan></text>
> +    </g>
> +    <path
> +       style=3D"fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWideRounded)"
> +       d=3D"m 56.046208,133.69217 h -4.894792 v 58.07604"
> +       id=3D"path24"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray=
:1,1;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +       d=3D"m 95.977781,134.7651 v 15.92063 l 23.944789,0.007"
> +       id=3D"path25"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 116.34935,212.1162 h 16.22753"
> +       id=3D"path26"
> +       sodipodi:nodetypes=3D"cc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff6600;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"159.95955"
> +       y=3D"214.49745"
> +       id=3D"text26"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"159.95955"
> +         y=3D"214.49745"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ffd42a;stroke-width:0.0690111"
> +         id=3D"tspan26">PSP Interaction</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 142.93997,177.44941 12.78794,1e-5 0,-20.13841"
> +       id=3D"path27"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 154.31705,177.44941 24.03273,1e-5 v -46.34286 h -6.87917"
> +       id=3D"path28"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <rect
> +       style=3D"fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-=
dasharray:none"
> +       id=3D"rect31"
> +       width=3D"28.449656"
> +       height=3D"23.148542"
> +       x=3D"-9.3648224"
> +       y=3D"152.25124" />
> +    <rect
> +       style=3D"fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-=
dasharray:none"
> +       id=3D"rect32"
> +       width=3D"28.449656"
> +       height=3D"23.148542"
> +       x=3D"-9.3648224"
> +       y=3D"71.817902" />
> +    <rect
> +       style=3D"fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-=
dasharray:none"
> +       id=3D"rect33"
> +       width=3D"28.449656"
> +       height=3D"23.148542"
> +       x=3D"198.46539"
> +       y=3D"152.25124" />
> +    <rect
> +       style=3D"fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-=
dasharray:none"
> +       id=3D"rect34"
> +       width=3D"28.449656"
> +       height=3D"23.148542"
> +       x=3D"198.46539"
> +       y=3D"71.817902" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 69.17932,192.92241 0,-26.32924 H 34.403946"
> +       id=3D"path35"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 69.167488,192.92241 0,-26.32924 H 184.79581"
> +       id=3D"path36"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 33.58103,118.30671 147.61609,0 v 30.03021"
> +       id=3D"path37"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 169.94852,126.77338 15.61123,0"
> +       id=3D"path38"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 172.24035,148.99838 13.3194,0"
> +       id=3D"path39"
> +       sodipodi:nodetypes=3D"cc" />
> +    <g
> +       id=3D"g40"
> +       transform=3D"translate(0,1.8520834)">
> +      <circle
> +         style=3D"fill:#ff8080;stroke:#ff2a2a;stroke-width:0.7;stroke-da=
sharray:none;stroke-dashoffset:0"
> +         id=3D"path40"
> +         cx=3D"7.2723336"
> +         cy=3D"194.07741"
> +         r=3D"10.186459" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:4.23333=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"7.1728497"
> +         y=3D"195.6649"
> +         id=3D"text40"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"7.1728492"
> +           y=3D"195.6649"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan40">Firmware</tspan></text>
> +    </g>
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 34.063928,177.71401 78.801482,0.26458"
> +       id=3D"path41"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"M 8.1347613,184.72547 27.537285,177.97859"
> +       id=3D"path42"
> +       sodipodi:nodetypes=3D"cc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"4.5742564"
> +       y=3D"84.897125"
> +       id=3D"text42"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"4.5742559"
> +         y=3D"84.897125"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan42">Memory</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"4.5742564"
> +       y=3D"165.33046"
> +       id=3D"text43"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"4.5742559"
> +         y=3D"165.33046"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan43">Memory</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"212.40446"
> +       y=3D"165.33046"
> +       id=3D"text44"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"212.40446"
> +         y=3D"165.33046"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan44">Memory</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"212.40446"
> +       y=3D"84.897125"
> +       id=3D"text45"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"212.40446"
> +         y=3D"84.897125"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan45">Memory</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:0.882664;stroke-da=
sharray:0.882664, 0.882664;stroke-dashoffset:0"
> +       d=3D"m 174.12438,77.957755 h 10.9062"
> +       id=3D"path45"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:0.960226;stroke-da=
sharray:0.960226, 0.960226;stroke-dashoffset:0"
> +       d=3D"M 34.639355,77.957755 H 47.546469"
> +       id=3D"path46"
> +       sodipodi:nodetypes=3D"cc" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dashar=
ray:none"
> +       id=3D"rect2"
> +       width=3D"5.0221987"
> +       height=3D"111.47456"
> +       x=3D"28.691442"
> +       y=3D"72.435623" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.93889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"-127.03961"
> +       y=3D"32.94923"
> +       id=3D"text34"
> +       transform=3D"rotate(-90)"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-127.03961"
> +         y=3D"32.94923"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#008033;stroke-width:0.0690111"
> +         id=3D"tspan34">UMC</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 179.15481,177.45676 h 5.90877"
> +       id=3D"path1"
> +       sodipodi:nodetypes=3D"cc" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dashar=
ray:none"
> +       id=3D"rect3"
> +       width=3D"5.0221987"
> +       height=3D"111.47456"
> +       x=3D"185.4259"
> +       y=3D"72.435623" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.93889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"-127.03961"
> +       y=3D"189.71486"
> +       id=3D"text35"
> +       transform=3D"rotate(-90)"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-127.03961"
> +         y=3D"189.71486"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#008033;stroke-width:0.0690111"
> +         id=3D"tspan35">UMC</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 154.31705,177.44941 24.03273,1e-5 0,-85.765777 h -4.36563"
> +       id=3D"path4"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <g
> +       id=3D"g5"
> +       transform=3D"translate(0,5.8208336)">
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"110.18288"
> +         y=3D"73.872185"
> +         id=3D"text14-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"110.18288"
> +           y=3D"73.872185"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan14-7">Graphics &amp; Compute (GC)</tspan></text>
> +      <g
> +         id=3D"g4"
> +         transform=3D"translate(10.583333)">
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:5.644=
44px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x=3D"58.022533"
> +           y=3D"83.518799"
> +           id=3D"text14-7-5"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"58.022533"
> +             y=3D"83.518799"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan14-7-6">Shader</tspan><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"58.022533"
> +             y=3D"90.574348"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan20">Engine(SE)</tspan><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"58.022533"
> +             y=3D"97.629898"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan21">#1</tspan></text>
> +        <rect
> +           style=3D"fill:none;stroke:#aa0000;stroke-width:1.01356;stroke=
-dasharray:none;stroke-dashoffset:0"
> +           id=3D"rect20"
> +           width=3D"31.954243"
> +           height=3D"22.038303"
> +           x=3D"42.18652"
> +           y=3D"77.410309" />
> +      </g>
> +      <g
> +         id=3D"g3"
> +         transform=3D"translate(14.287499,-0.66146851)">
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:5.644=
44px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x=3D"97.020706"
> +           y=3D"91.105995"
> +           id=3D"text24"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"97.020706"
> +             y=3D"91.105995"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan24">SE #2</tspan></text>
> +        <rect
> +           style=3D"fill:none;stroke:#aa0000;stroke-width:1.01356;stroke=
-dasharray:none;stroke-dashoffset:0"
> +           id=3D"rect24"
> +           width=3D"31.954243"
> +           height=3D"22.038303"
> +           x=3D"81.080269"
> +           y=3D"78.071777" />
> +      </g>
> +      <g
> +         id=3D"g2"
> +         transform=3D"translate(-3.96875)">
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:5.644=
44px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x=3D"158.03574"
> +           y=3D"90.444527"
> +           id=3D"text30"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"158.03574"
> +             y=3D"90.444527"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.0690111"
> +             id=3D"tspan30">SE #N</tspan></text>
> +        <rect
> +           style=3D"fill:none;stroke:#aa0000;stroke-width:1.01356;stroke=
-dasharray:none;stroke-dashoffset:0"
> +           id=3D"rect30"
> +           width=3D"31.954243"
> +           height=3D"22.038303"
> +           x=3D"141.93443"
> +           y=3D"77.410309" />
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"132.011"
> +         y=3D"88.873962"
> +         id=3D"text4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"132.011"
> +           y=3D"88.873962"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan4">...</tspan></text>
> +      <rect
> +         style=3D"fill:none;stroke:#ff8080;stroke-width:1;stroke-dasharr=
ay:none"
> +         id=3D"rect4"
> +         width=3D"126.7475"
> +         height=3D"35.863121"
> +         x=3D"46.912045"
> +         y=3D"68.129692" />
> +    </g>
> +    <g
> +       id=3D"g11"
> +       transform=3D"translate(-5.0270833,-8.8635417)">
> +      <rect
> +         style=3D"fill:#ffffff;stroke:#5f5fd3;stroke-width:1;stroke-dash=
array:none"
> +         id=3D"rect19"
> +         width=3D"28.674419"
> +         height=3D"11.302325"
> +         x=3D"146.1279"
> +         y=3D"132.70711" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"160.75085"
> +         y=3D"140.62521"
> +         id=3D"text19"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"160.75085"
> +           y=3D"140.62521"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan19">VCN</tspan></text>
> +    </g>
> +    <g
> +       id=3D"g6">
> +      <rect
> +         style=3D"fill:#ffffff;stroke:#0000ff;stroke-width:1;stroke-dash=
array:none"
> +         id=3D"rect13"
> +         width=3D"28.674419"
> +         height=3D"11.302325"
> +         x=3D"43.988369"
> +         y=3D"192.98618" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x=3D"58.325581"
> +         y=3D"200.90428"
> +         id=3D"text14"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"58.325581"
> +           y=3D"200.90428"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.0690111"
> +           id=3D"tspan14">DCN</tspan></text>
> +    </g>
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index 3a34b7d181ff..1b864c0ae842 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -231,9 +231,18 @@ we have a dedicated glossary for Display Core at
>        stages had different cache designs; it refers to the L1 cache in o=
lder
>        architectures.
>
> +    TMR
> +      Trusted Memory Area
> +
> +    TMZ
> +      Trusted Memory Zone
> +
>      TOC
>        Table of Contents
>
> +    UMC
> +      Unified Memory Controller
> +
>      UMSCH
>        User Mode Scheduler
>
> diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documenta=
tion/gpu/amdgpu/display/dc-glossary.rst
> index cbe737d1fcea..accb7c05308c 100644
> --- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
> +++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
> @@ -221,9 +221,6 @@ consider asking on the amd-gfx mailing list and updat=
e this page.
>      TMDS
>        Transition-Minimized Differential Signaling
>
> -    TMZ
> -      Trusted Memory Zone
> -
>      TTU
>        Time to Underflow
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu=
/amdgpu/driver-core.rst
> index 3ce276272171..2c2bbf7caf1a 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -77,6 +77,37 @@ VCN (Video Core Next)
>      decode.  It's exposed to userspace for user mode drivers (VA-API,
>      OpenMAX, etc.)
>
> +It is important to note that these blocks can interact with each other. =
The
> +picture below illustrates some of the components and their interconnecti=
on:
> +
> +.. kernel-figure:: amd_overview_block.svg
> +
> +In the diagram, memory-related blocks are shown in green. Notice that sp=
ecific
> +IPs have a green square that represents a small hardware block named 'hu=
b',
> +which is responsible for interfacing with memory. All memory hubs are co=
nnected
> +in the UMCs, which in turn are connected to memory blocks. As a note,
> +pre-vega devices have a dedicated block for the Graphic Memory Controlle=
r
> +(GMC), which was replaced by UMC and hubs in new architectures. In the d=
river
> +code, you can identify this component by looking for the suffix hub, for
> +example: gfxhub, dchub, mmhub, vmhub, etc. Keep in mind that the compone=
nt's
> +interaction with the memory block may vary across architectures. For exa=
mple,
> +on Navi and newer, GC and SDMA are both attached to GCHUB; on pre-Navi, =
SDMA
> +goes through MMHUB; VCN, JPEG, and VPE go through MMHUB; DCN goes throug=
h
> +DCHUB.
> +
> +There is some protection for certain memory elements, and the PSP plays =
an
> +essential role in this area. When a specific firmware is loaded into mem=
ory,
> +the PSP takes steps to ensure it has a valid signature. It also stores f=
irmware
> +images in a protected memory area named Trusted Memory Area (TMR), so th=
e OS or
> +driver can't corrupt them at runtime. Another use of PSP is to support T=
rusted
> +Applications (TA), which are basically small applications that run on th=
e
> +trusted processor and handles a trusted operation (e.g., HDCP). PSP is a=
lso
> +used for encrypted memory for content protection via Trusted Memory Zone=
 (TMZ).
> +
> +Another critical IP is the SMU. It handles reset distribution, as well a=
s
> +clock, thermal, and power management for all IPs on the SoC. SMU also he=
lps to
> +balance performance and power consumption.
> +
>  .. _pipes-and-queues-description:
>
>  GFX, Compute, and SDMA Overall Behavior
> --
> 2.51.0
>
