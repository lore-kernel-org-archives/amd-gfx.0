Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A45CCD1A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 20:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948F210E4FE;
	Mon, 20 Oct 2025 20:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IAvyll4v";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC1010E4FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 20:29:04 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-290aaff26c1so12239635ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760992144; x=1761596944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYfU9jclwggQSvxZzYSYpBJ7uaGIEzSWl0q2YjbCBsw=;
 b=IAvyll4vAeHsPXsu9jEWxN8zhQDLE97q09hhNiVQhg6xC645gqHF5iQdGNTaX9N42X
 oeQN07iWM38J6uoSdjEmxauj+LuOyVAjQHyQBWguStMdnadVF7bzMPjNIJodNYEdPOIP
 XDXPSvu6pd8ieatPJBcnZnbMD2h817mpfaATDPASldGYCfAttNESRtoUrbeyBFnEe/0M
 8CSXYIdQu3eCwVXsg6PThblDRddpLEqYzLhdcyDTa5+KfGSoH24SFPbb9rs5hXdyz5GT
 PfzZ28SWze84UUhIvegQihNqjLvml/iVXQVqNvYz+VXY+Xh2hI4DjwdN9YgJ+osSQl/l
 OhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760992144; x=1761596944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYfU9jclwggQSvxZzYSYpBJ7uaGIEzSWl0q2YjbCBsw=;
 b=D8iRaUHQvee9T0cNBQRidl+JGm0zTjQeA3y6tJ7TeguLjZNAL5WbTzXU8yyxLaxpoW
 162aq04S2sq2q61wldeW2yW5QUpkZacd2jktDHacn39r74fQ9uaPSP1COTAcaRWBGGwU
 YK+ByMToR4IIf27jqGy8Jdf1Obz2ypU3f7oe1ZUZf9ndCQndi8PaVBP+w69IyPfF55qh
 zAYaQOqcdQBbZ0Zgjm7He+tgc2oHplt9GKm8Z97KyX1GB9aqMVO8SulWo+k36/tH05yw
 KcWMi3FtgK7dQ5jq+VfFOef4c9S+MMT3hVGDSJWuRXAt+mtOUYOmeE4HbSE06wMTgdwM
 /1Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg911SY5nehFgQ8BGYAWdQcEWOa8Ozx6kKMlp9B9Y4wq0RiAJL+rykoay7ctaLMbZ6V5Au6N6B@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9JAWGhKt+dF0oxm23H8c7qtKiI3y9hkIqg3msEATmJBjnsuXo
 Ovve4yskg6WDVAfltwD891MpyNGz8Pojqpt6IiIV/WGh2AVeTc5s5lbYmqcwcUJix/0uC78CP6q
 V/bOMF60Csbd1jOHJzy8WFGldxF+yYnI=
X-Gm-Gg: ASbGncv5E0Ab12IohtJF+CpKSh/o2WOIIKkyUmxQ5wlJnfUhUabwoxv2DyFRfzvvC4G
 a7ibLh6PJXeIAtWIze3WTASGk0I4yWb6YGgSrpIJOUVNIAzjg7JF8EbtCVGd94oJBIggzJeFoui
 KHktmKEA044fjPRjN8WoiGkMsMUJpsCi8CrCNvlrt5y0rKUIUAGgMH76kkUbD8EKJZxH87MJKk9
 ie7HurDCtTAgpjEDDUN3I9ZcwF8prhcaLQveR4Px0AG1eGyGN03ZSt7RSNh
X-Google-Smtp-Source: AGHT+IFWSlMzCXLZ9ItjOggvRMA6FDI9MW0TB+UJkcRiXbmBxqsAE8NP107ccOEKnoggxtecROFnEFnSDdyDA3J0pME=
X-Received: by 2002:a17:902:e786:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-292d3e61446mr4644875ad.4.1760992143677; Mon, 20 Oct 2025
 13:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-4-siqueira@igalia.com>
In-Reply-To: <20251020194631.102260-4-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 16:28:51 -0400
X-Gm-Features: AS18NWBjnVl3iDrAssgUOfr6l2HB5y9JrQT8xf3agwovUIj1DJUJrbZ3az15DV4
Message-ID: <CADnq5_N--t-WbwRC9fuo55cfP8p4Cc-MsdYG11rt0zqaXnkSFQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Documentation/gpu: Expand generic block information
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

On Mon, Oct 20, 2025 at 3:56=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
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
>  .../gpu/amdgpu/amd_overview_block.svg         | 674 ++++++++++++++++++
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
>  Documentation/gpu/amdgpu/driver-core.rst      |  25 +
>  3 files changed, 702 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
>
> diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Documentat=
ion/gpu/amdgpu/amd_overview_block.svg
> new file mode 100644
> index 000000000000..8d9ae95bd9a5
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/amd_overview_block.svg

Got a link to the diagram anywhere?  These looked good at XDC.

> @@ -0,0 +1,674 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"237.4014mm"
> +   height=3D"160.98259mm"
> +   viewBox=3D"0 0 237.4014 160.98259"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4 (e7c3feb100, 2024-10-09)"
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
> +     inkscape:cx=3D"436.25"
> +     inkscape:cy=3D"313.75"
> +     inkscape:window-width=3D"3072"
> +     inkscape:window-height=3D"1651"
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
> +       style=3D"fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dashar=
ray:none"
> +       id=3D"rect2"
> +       width=3D"5.0232558"
> +       height=3D"104.23256"
> +       x=3D"28.674419"
> +       y=3D"72.418602" />
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dashar=
ray:none"
> +       id=3D"rect3"
> +       width=3D"5.0232558"
> +       height=3D"104.23256"
> +       x=3D"185.44186"
> +       y=3D"72.418602" />
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect8-5"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"48.522045"
> +       y=3D"75.819946" />
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect9"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"168.14684"
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
> +    <rect
> +       style=3D"fill:#ffffff;stroke:#0000ff;stroke-width:1;stroke-dashar=
ray:none"
> +       id=3D"rect13"
> +       width=3D"28.674419"
> +       height=3D"11.302325"
> +       x=3D"43.988369"
> +       y=3D"192.98618" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"58.325581"
> +       y=3D"200.90428"
> +       id=3D"text14"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"58.325581"
> +         y=3D"200.90428"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.0690111"
> +         id=3D"tspan14">DCN</tspan></text>
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
> +       x=3D"164.57497"
> +       y=3D"125.16281" />
> +    <rect
> +       style=3D"fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke=
-dasharray:none"
> +       id=3D"rect18"
> +       width=3D"3.8659263"
> +       height=3D"4.2845292"
> +       x=3D"67.340591"
> +       y=3D"194.48364" />
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
> +           x=3D"0.79788309"
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
> +       d=3D"m 142.93997,177.05254 12.78794,1e-5 v -20.13841"
> +       id=3D"path27"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"m 154.31705,177.05254 24.03273,1e-5 v -47.79807 h -6.87917"
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
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.93889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"-124.65836"
> +       y=3D"32.94923"
> +       id=3D"text34"
> +       transform=3D"rotate(-90)"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-124.65836"
> +         y=3D"32.94923"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#008033;stroke-width:0.0690111"
> +         id=3D"tspan34">UMC</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.93889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x=3D"-124.65836"
> +       y=3D"189.71486"
> +       id=3D"text35"
> +       transform=3D"rotate(-90)"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-124.65836"
> +         y=3D"189.71486"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#008033;stroke-width:0.0690111"
> +         id=3D"tspan35">UMC</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"M 69.069766,195.36981 V 166.59317 H 34.403946"
> +       id=3D"path35"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"M 69.167488,195.36981 V 166.59317 H 184.79581"
> +       id=3D"path36"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 33.58103,118.30671 h 141.39539 v 30.03021"
> +       id=3D"path37"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 166.53415,126.77338 h 19.0256"
> +       id=3D"path38"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 166.53415,148.99838 h 19.0256"
> +       id=3D"path39"
> +       sodipodi:nodetypes=3D"cc" />
> +    <g
> +       id=3D"g40"
> +       transform=3D"translate(0,-1.8520833)">
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
> +       d=3D"m 34.063928,174.00984 78.801482,0.26458"
> +       id=3D"path41"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray=
:8, 1;stroke-dashoffset:0"
> +       d=3D"M 8.1347613,181.0213 27.537285,174.27442"
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
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 171.56123,77.957755 13.99852,0"
> +       id=3D"path45"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray=
:1, 1;stroke-dashoffset:0"
> +       d=3D"m 34.639355,77.957755 h 13.99852"
> +       id=3D"path46"
> +       sodipodi:nodetypes=3D"cc" />
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation=
/gpu/amdgpu/amdgpu-glossary.rst
> index eb72e6f6d4f1..a3f9565d655b 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -227,6 +227,9 @@ we have a dedicated glossary for Display Core at
>      TOC
>        Table of Contents
>
> +    UMC
> +      Unified Memory Controller
> +
>      UMSCH
>        User Mode Scheduler
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu=
/amdgpu/driver-core.rst
> index 3ce276272171..13f13e2e5497 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -77,6 +77,31 @@ VCN (Video Core Next)
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
> +In the diagram, memory-related blocks are represented by a green color. =
Notice
> +that specific IPs have a green block that represents a small hardware bl=
ock
> +named 'hub', which is responsible for interfacing with memory (pre-vega =
devices
> +have a dedicated block for that, named GMC). In the driver code, you can
> +identify this component by looking for the suffix hub, for example: gfxh=
ub,
> +dchub, mmhub, vmhub, etc. All memory hubs are connected in the UMC, whic=
h in

All memory hubs are connected to the UMCs, which in

> +turn is connected to memory blocks.
> +
> +There is some level of protection for certain elements in memory, and th=
e PSP
> +plays an essential role in this area. For example, when a specific firmw=
are is
> +loaded into the memory, PSP takes an action to ensure that the firmware =
has a
> +valid signature.

It also stores the firmware images in a protected memory area (TMR =3D
Trusted Memory Area) so the OS or driver can't corrupt it at runtime
after it's been validated.

> Another use of PSP is to support the TA (e.g., HDCP) and

TA =3D Trusted Application
Basically small application that runs on the trusted processor and
handles a trusted operation.

> +encrypted memory via TMZ.

TMZ (Trusted Memory Zone -- encrypted memory for content protection).

> +
> +Another IP that deserves attention is the SMU, as it is connected to all=
 the
> +other IPs. SMU will help put the GPU in optimal utilization by taking in=
to
> +account performance and power consumption. SMU helps other blocks to set=
 up a
> +proper clock configuration. Another feature of SMU is the support for re=
setting
> +every component.

How about something like:

Another important IP is the SMU.  It handles reset distribution as
well as clock and power management for all of the IPs on the SoC.

Alex

> +
>  .. _pipes-and-queues-description:
>
>  GFX, Compute, and SDMA Overall Behavior
> --
> 2.51.0
>
