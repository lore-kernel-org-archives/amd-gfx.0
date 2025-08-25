Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A7CCA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 15:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28EA10E4F9;
	Mon, 25 Aug 2025 15:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvl2IO9T";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8789110E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:59:07 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b4716f9a467so645086a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756137547; x=1756742347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHr2ymI26x5lfy8KZEPqt+Yl1/Vz0g1FgGUsxiU5jGc=;
 b=gvl2IO9TqCto4+l7pg5ZEPcKfK3RSKSQiJmT9IMBUWuZEDZpP2+IDnNagkNAPQsVME
 sreofXX0oaI+KgMCKcaxN5vdepHpvZ1sGp9FbEwWNCXDXI5BTgELL2IpBYLX/FeMa1Kf
 c3iq1BslTLAZrRRxf4eKjBhMjsSP+41THNIa1ciuV9YYCj+5pkt8/hP9jrENVEpDZFWA
 7IhSzDaeuTN2yyfxqf0asiVAzfQawiPxNm5KYeKIYx5/WmtDI88D4MEUGSQgEoVf7tHN
 AWXoIh11TW18qgpShLVu62dEb9eGXI5x6hXNOlrIxuy3hYR+wuWhwIeCcrxR2DhFqrlj
 BCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756137547; x=1756742347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHr2ymI26x5lfy8KZEPqt+Yl1/Vz0g1FgGUsxiU5jGc=;
 b=EcUT0Oh427+UIhZuJXQHO5Ljiw6bLXjSXCAysAYoH526zQOkiWojdAF9opzMaqqUJ4
 aGCK+7pYEHH3srJMomIU2PmfGIEOnbLW7oWpMLR5+3f1CF6rWe+blbtJVLKw0CgZ4dDq
 oeI0XFzGYJC/e0mSEV3QKnBSfR4APzAPcacQ6Gk0Gkr06zctrniT1WPFXyzkunRs9mN3
 L1dQzV8XyhwAHAX/ai/2BtJ61zF5faxJGgFJztLX6Q06n2QzjybjA4e2oGdCxRVnlEDY
 9VSUdAXof1e4B1gCdc8W4sFJyf2D4O/TbFrBIOjWBYTTr168aOzoMq3oeKOCVgPEm09p
 3IVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKpDLpSKZUyxbMPfJqo1ycQLksDgfxHOoamh6PhIZVogNepVaobm5UCfddV3EJBtWOF/a/0tjL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc7uQq4PIT1iLGJAByaxSSwlsveNeGl+Fx53V+lqiKticDhruX
 OunU6cBMcFF+MZwK0EbpEmLm3bJYYTK3XAsW7XJJ4BQooKPFoEnE9uyhD/9KyJu8+UUBGpQp/+0
 XqkYDXpb/8E9+72mgrZ1iKOzo5/X9zcau+Xq8
X-Gm-Gg: ASbGncu949CnFx0tXdX2CkSZRAwZ4yzrYJPEDxMviEvTI1tDStv1T1AO2T19zdYAkOz
 JRyYwHoO+hJvnkLnbAjwupdD8tdT4w4kj04w56EIVstAjUOjK+DIRNWTygp12iMI/VJUcNf9Sur
 1QAjIykc1GonWN0jz1xh6JiiPwWUGksybIuDvYCTm62MZxl9o9Kgd7stJtSozqwsZ/ljUUf/WU4
 XPz+aU=
X-Google-Smtp-Source: AGHT+IEC47PWnl9lWg36VB4WxeOMpprnezKBGFoeMUANSoMOeY1apcxyD0T+H/GHmjEx4CZqI4GjncCPnE9rOtWLDnE=
X-Received: by 2002:a17:902:f711:b0:246:5d07:842f with SMTP id
 d9443c01a7336-2465d078881mr73875345ad.1.1756137546628; Mon, 25 Aug 2025
 08:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-6-siqueira@igalia.com>
In-Reply-To: <20250824233149.3780127-6-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 11:58:54 -0400
X-Gm-Features: Ac12FXwfsZqcNJVVtbS5cRFXEeV3g7Am9SgbdBi1KVZoVWpUL29Y5nNhuehEv0w
Message-ID: <CADnq5_NFJ=Xv+jGW8BLtEUFyxN5PAuWAGOxW8RPnVSkRyoDgeQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Documentation/gpu: Add documentation about ring
 buffer
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

On Sun, Aug 24, 2025 at 7:58=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> AMDGPU heavily relies on ring buffers to manage its components; as a
> result, it has an elaborate mechanism of operation with multiple details
> around it. This commit introduces new documentation on ring buffers,
> detailing their management and expanding the explanation of Enforce
> isolation. Finally, this commit also adds the documentation available in
> the amdgpu_ring.c file to it.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  .../gpu/amdgpu/enforce_isolation.svg          |  707 +++++++
>  Documentation/gpu/amdgpu/gfx_pipeline_seq.svg |  413 +++++
>  Documentation/gpu/amdgpu/index.rst            |    1 +
>  .../gpu/amdgpu/no_enforce_isolation.svg       |  673 +++++++
>  Documentation/gpu/amdgpu/ring-buffer.rst      |   94 +
>  Documentation/gpu/amdgpu/ring_buffers.svg     | 1633 +++++++++++++++++
>  6 files changed, 3521 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/enforce_isolation.svg
>  create mode 100644 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
>  create mode 100644 Documentation/gpu/amdgpu/no_enforce_isolation.svg
>  create mode 100644 Documentation/gpu/amdgpu/ring-buffer.rst
>  create mode 100644 Documentation/gpu/amdgpu/ring_buffers.svg
>

Do you have links to the images?

> diff --git a/Documentation/gpu/amdgpu/enforce_isolation.svg b/Documentati=
on/gpu/amdgpu/enforce_isolation.svg
> new file mode 100644
> index 000000000000..b224615e1611
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/enforce_isolation.svg
> @@ -0,0 +1,707 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"68.949203mm"
> +   height=3D"86.909332mm"
> +   viewBox=3D"0 0 68.949202 86.909332"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname=3D"enforce_isolation.svg"
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
> +     inkscape:zoom=3D"1.7877362"
> +     inkscape:cx=3D"291.15034"
> +     inkscape:cy=3D"332.54347"
> +     inkscape:window-width=3D"3072"
> +     inkscape:window-height=3D"1651"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     inkscape:current-layer=3D"g61" />
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
> +       id=3D"Dot"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Dot"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2=
.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes=3D"sssss"
> +         id=3D"path98" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"marker99"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Dot"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2=
.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes=3D"sssss"
> +         id=3D"path99" />
> +    </marker>
> +  </defs>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(72.009598,0.94510132)">
> +    <g
> +       id=3D"g61">
> +      <rect
> +         style=3D"fill:#ffffff;stroke:none;stroke-width:0.25654;stroke-l=
inecap:square;stroke-dasharray:none"
> +         id=3D"rect6"
> +         width=3D"68.949203"
> +         height=3D"86.909332"
> +         x=3D"-72.009598"
> +         y=3D"-0.94510132" />
> +      <g
> +         id=3D"g15"
> +         transform=3D"matrix(0.42247861,0,0,0.42247861,-70.575576,-29.75=
6289)">
> +        <path
> +           id=3D"path33"
> +           style=3D"fill:none;stroke:#000000;stroke-width:0.721067;strok=
e-dasharray:none"
> +           d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737=
955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.90=
5334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537=
 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.7=
72359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.772=
46 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +        <g
> +           id=3D"g14">
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 46.31405,200.72093 h 6.430134"
> +             id=3D"path34"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 7.6848605,200.72093 H 14.114993"
> +             id=3D"path35"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 30.103415,176.7326 v 6.43014"
> +             id=3D"path36"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 30.103415,215.50586 V 221.936"
> +             id=3D"path37"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +             id=3D"path38"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +             id=3D"path39"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +             id=3D"path40"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +             id=3D"path41"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +             id=3D"path42"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +             id=3D"path43"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +             id=3D"path44-1"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +             id=3D"path45-8"
> +             sodipodi:nodetypes=3D"cc" />
> +        </g>
> +      </g>
> +      <rect
> +         style=3D"fill:#afe9c6;stroke:#16502d;stroke-width:0.257104;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +         id=3D"rect80"
> +         width=3D"25.076588"
> +         height=3D"10.493422"
> +         x=3D"-71.362038"
> +         y=3D"74.63459"
> +         ry=3D"1.4529352" />
> +      <rect
> +         style=3D"fill:#80e5ff;stroke:#00aad4;stroke-width:0.257104;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +         id=3D"rect81"
> +         width=3D"32.714355"
> +         height=3D"10.436013"
> +         x=3D"-40.481403"
> +         y=3D"74.663292"
> +         ry=3D"1.4449863" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.53042=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-59.013123"
> +         y=3D"82.212669"
> +         id=3D"text14-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-59.013123"
> +           y=3D"82.212669"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.53042px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan14-7">GFX</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.53042=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-24.387218"
> +         y=3D"81.46167"
> +         id=3D"text95"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-24.387218"
> +           y=3D"81.46167"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.53042px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan95">Compute</tspan></text>
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.385656;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -58.079264,73.89605 V 65.448872"
> +         id=3D"path127"
> +         sodipodi:nodetypes=3D"cc" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.90242=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-61.752651"
> +         y=3D"3.1995225"
> +         id=3D"text112"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-61.752651"
> +           y=3D"3.1995225"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.90242px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan112">Processes</tspan></text>
> +      <rect
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.247306;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:1.48383, 1.48383;stro=
ke-dashoffset:0"
> +         id=3D"rect113"
> +         width=3D"64.703476"
> +         height=3D"19.562067"
> +         x=3D"-68.52655"
> +         y=3D"4.468956"
> +         ry=3D"1.6976216" />
> +      <g
> +         id=3D"g84"
> +         transform=3D"matrix(0.25710378,0,0,0.25710378,0.68647434,8.7899=
633)">
> +        <g
> +           id=3D"g83">
> +          <circle
> +             style=3D"fill:#ffffff;stroke:#ff00ff;stroke-width:1.62704;s=
troke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-das=
hoffset:0"
> +             id=3D"circle137"
> +             cx=3D"-225.65012"
> +             cy=3D"20.747513"
> +             r=3D"30.822298" />
> +        </g>
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:16.93=
33px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-225.65012"
> +           y=3D"26.8181"
> +           id=3D"text113"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-225.65012"
> +             y=3D"26.8181"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#ff00ff;stroke-width:0.400612"
> +             id=3D"tspan113">A</tspan></text>
> +      </g>
> +      <g
> +         id=3D"g85"
> +         transform=3D"matrix(0.25710378,0,0,0.25710378,20.618429,8.78996=
33)">
> +        <circle
> +           style=3D"fill:#ffffff;stroke:#ff9955;stroke-width:1.62704;str=
oke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dasho=
ffset:0"
> +           id=3D"circle112"
> +           cx=3D"-207.94376"
> +           cy=3D"20.747513"
> +           r=3D"30.822298" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:16.93=
33px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-208.25702"
> +           y=3D"26.792702"
> +           id=3D"text114"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-208.25702"
> +             y=3D"26.792702"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#ff9955;stroke-width:0.400612"
> +             id=3D"tspan114">B</tspan></text>
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-56.126556"
> +         y=3D"47.212101"
> +         id=3D"text6"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-56.126556"
> +           y=3D"47.212101"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan6">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.26752=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-57.861526"
> +         y=3D"53.902462"
> +         id=3D"text136"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-57.861526"
> +           y=3D"53.902462"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan136">Ring</tspan><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-57.861526"
> +           y=3D"56.736862"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan137">Buffer</tspan></text>
> +      <g
> +         id=3D"g80"
> +         transform=3D"matrix(0.42247861,0,0,0.42247861,-37.21188,-29.756=
289)">
> +        <path
> +           id=3D"path67"
> +           style=3D"fill:none;stroke:#000000;stroke-width:0.721067;strok=
e-dasharray:none"
> +           d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737=
955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.90=
5334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537=
 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.7=
72359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.772=
46 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +        <g
> +           id=3D"g79">
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 46.31405,200.72093 h 6.430134"
> +             id=3D"path68"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 7.6848605,200.72093 H 14.114993"
> +             id=3D"path69"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 30.103415,176.7326 v 6.43014"
> +             id=3D"path70"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 30.103415,215.50586 V 221.936"
> +             id=3D"path71"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +             id=3D"path72"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +             id=3D"path73"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +             id=3D"path74"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +             id=3D"path75"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +             id=3D"path76"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +             id=3D"path77"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +             id=3D"path78"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +             id=3D"path79"
> +             sodipodi:nodetypes=3D"cc" />
> +        </g>
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.26752=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-24.497828"
> +         y=3D"53.902462"
> +         id=3D"text81"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-24.497828"
> +           y=3D"53.902462"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan80">Ring</tspan><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-24.497828"
> +           y=3D"56.736862"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.102999"
> +           id=3D"tspan81">Buffer</tspan></text>
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.385656;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -24.338879,73.89605 V 65.448872"
> +         id=3D"path81"
> +         sodipodi:nodetypes=3D"cc" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-52.574932"
> +         y=3D"48.826473"
> +         id=3D"text82"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-52.574932"
> +           y=3D"48.826473"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan82">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-50.045757"
> +         y=3D"52.862404"
> +         id=3D"text83"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-50.045757"
> +           y=3D"52.862404"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan83">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-31.907158"
> +         y=3D"58.226768"
> +         id=3D"text83-59"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-31.907158"
> +           y=3D"58.226768"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan83-7">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-32.436516"
> +         y=3D"53.169308"
> +         id=3D"text83-59-3"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-32.436516"
> +           y=3D"53.169308"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan83-7-6">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-65.422112"
> +         y=3D"57.972916"
> +         id=3D"text83-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-65.422112"
> +           y=3D"57.972916"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan83-8">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-65.713165"
> +         y=3D"52.732723"
> +         id=3D"text83-7-4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-65.713165"
> +           y=3D"52.732723"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.102999"
> +           id=3D"tspan83-8-3">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-52.897129"
> +         y=3D"61.668709"
> +         id=3D"text83-5"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-52.897129"
> +           y=3D"61.668709"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.102999"
> +           id=3D"tspan83-4">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-19.174068"
> +         y=3D"49.045818"
> +         id=3D"text83-5-9"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-19.174068"
> +           y=3D"49.045818"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.102999"
> +           id=3D"tspan83-4-2">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-16.531792"
> +         y=3D"53.259804"
> +         id=3D"text83-5-9-9"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-16.531792"
> +           y=3D"53.259804"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.102999"
> +           id=3D"tspan83-4-2-5">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-19.325029"
> +         y=3D"61.488995"
> +         id=3D"text83-5-9-9-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-19.325029"
> +           y=3D"61.488995"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff9955;stroke-width:0.102999"
> +           id=3D"tspan83-4-2-5-2">B</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-22.869593"
> +         y=3D"63.231686"
> +         id=3D"text83-5-9-9-7-0"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-22.869593"
> +           y=3D"63.231686"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff9955;stroke-width:0.102999"
> +           id=3D"tspan83-4-2-5-2-6">B</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-26.235374"
> +         y=3D"63.331181"
> +         id=3D"text83-5-9-9-7-0-4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-26.235374"
> +           y=3D"63.331181"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff9955;stroke-width:0.102999"
> +           id=3D"tspan83-4-2-5-2-6-9">B</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-56.235538"
> +         y=3D"63.072704"
> +         id=3D"text83-5-6"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-56.235538"
> +           y=3D"63.072704"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.102999"
> +           id=3D"tspan83-4-9">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.17681=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
> +         x=3D"-59.697765"
> +         y=3D"63.066635"
> +         id=3D"text83-5-6-5"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-59.697765"
> +           y=3D"63.066635"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.102999"
> +           id=3D"tspan83-4-9-2">C</tspan></text>
> +      <circle
> +         style=3D"fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"path83"
> +         cx=3D"-50.145481"
> +         cy=3D"57.387428"
> +         r=3D"1.0712636" />
> +      <circle
> +         style=3D"fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"path83-7"
> +         cx=3D"-16.886913"
> +         cy=3D"57.596024"
> +         r=3D"1.0712636" />
> +      <circle
> +         style=3D"fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"path83-7-7"
> +         cx=3D"-29.53648"
> +         cy=3D"60.832634"
> +         r=3D"1.0712636" />
> +      <circle
> +         style=3D"fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"path83-7-7-9"
> +         cx=3D"-29.751556"
> +         cy=3D"48.260994"
> +         r=3D"1.0712636" />
> +      <circle
> +         style=3D"fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"path83-4"
> +         cx=3D"-63.051891"
> +         cy=3D"60.73439"
> +         r=3D"1.0712636" />
> +      <circle
> +         style=3D"fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"path83-4-2"
> +         cx=3D"-63.022129"
> +         cy=3D"48.24374"
> +         r=3D"1.0712636" />
> +      <g
> +         id=3D"g86"
> +         transform=3D"matrix(0.25710378,0,0,0.25710378,17.422136,8.78996=
33)">
> +        <circle
> +           style=3D"fill:#ffffff;stroke:#ff0000;stroke-width:1.62704;str=
oke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dasho=
ffset:0"
> +           id=3D"circle84"
> +           cx=3D"-121.9205"
> +           cy=3D"20.747513"
> +           r=3D"30.822298" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:16.93=
33px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-122.11524"
> +           y=3D"26.792702"
> +           id=3D"text84"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-122.11524"
> +             y=3D"26.792702"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#ff0000;stroke-width:0.400612"
> +             id=3D"tspan84">C</tspan></text>
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-size:2.17681px;font-family:'Linux Libertine O';-i=
nkscape-font-specification:'Linux Libertine O';text-align:start;letter-spac=
ing:1.26323px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;=
stroke:#000000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray=
:none;stroke-dashoffset:0"
> +         x=3D"-140.03215"
> +         y=3D"26.074423"
> +         id=3D"text86"><tspan
> +           sodipodi:role=3D"line"
> +           id=3D"tspan86"
> +           style=3D"stroke-width:0.257104"
> +           x=3D"-140.03215"
> +           y=3D"26.074423" /></text>
> +      <g
> +         id=3D"g90"
> +         transform=3D"matrix(0.25710378,0,0,0.25710378,18.175509,7.82134=
)">
> +        <rect
> +           style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-linec=
ap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +           id=3D"rect86"
> +           width=3D"92.604057"
> +           height=3D"26.883123"
> +           x=3D"-338.30258"
> +           y=3D"93.635468" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:8.819=
44px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-291.13989"
> +           y=3D"110.58046"
> +           id=3D"text88"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-291.13989"
> +             y=3D"110.58046"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:8.81944px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.400612"
> +             id=3D"tspan88">Enforce Isolation</tspan></text>
> +      </g>
> +      <g
> +         id=3D"g89"
> +         transform=3D"matrix(0.25710378,0,0,0.25710378,18.606009,7.82134=
)">
> +        <rect
> +           style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-linec=
ap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +           id=3D"rect89"
> +           width=3D"119.67937"
> +           height=3D"26.749132"
> +           x=3D"-219.35185"
> +           y=3D"93.702461" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:8.819=
44px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-159.57832"
> +           y=3D"110.40636"
> +           id=3D"text89"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-159.57832"
> +             y=3D"110.40636"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:8.81944px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#1c241c;stroke-width:0.400612"
> +             id=3D"tspan89">Enforce Isolation</tspan></text>
> +      </g>
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.385656;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -57.807162,43.759556 V 39.878518"
> +         id=3D"path90"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.385656;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -24.512426,43.759556 V 39.878518"
> +         id=3D"path91"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:#ff00ff;stroke:#ff00ff;stroke-width:0.257104;stro=
ke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m -57.329023,22.418572 v 9.208373"
> +         id=3D"path1" />
> +      <path
> +         style=3D"fill:#ff00ff;stroke:#ff9955;stroke-width:0.257104;stro=
ke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m -32.844695,22.418572 v 9.208373"
> +         id=3D"path2" />
> +      <path
> +         style=3D"fill:#ff00ff;stroke:#ff0000;stroke-width:0.257104;stro=
ke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m -13.924085,22.418572 v 9.208373"
> +         id=3D"path4" />
> +      <path
> +         style=3D"fill:none;stroke:#ff00ff;stroke-width:0.257104;stroke-=
linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m -57.329023,22.418572 v 5.174952 h 20.852017 v 4.033421"
> +         id=3D"path5"
> +         sodipodi:nodetypes=3D"cccc" />
> +      <path
> +         style=3D"fill:none;stroke:#ff0000;stroke-width:0.257104;stroke-=
linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m -13.924085,22.418572 v 3.652908 h -34.777483 v 5.555465"
> +         id=3D"path6"
> +         sodipodi:nodetypes=3D"cccc" />
> +    </g>
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/gfx_pipeline_seq.svg b/Documentatio=
n/gpu/amdgpu/gfx_pipeline_seq.svg
> new file mode 100644
> index 000000000000..2f2c8fa98059
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
> @@ -0,0 +1,413 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"141.76276mm"
> +   height=3D"51.906979mm"
> +   viewBox=3D"0 0 141.76275 51.906979"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname=3D"gfx_pipeline_seq.svg"
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
> +     inkscape:zoom=3D"1.2641204"
> +     inkscape:cx=3D"470.28748"
> +     inkscape:cy=3D"63.680643"
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
> +  </defs>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(23.062206,-30.75877)">
> +    <rect
> +       style=3D"fill:#ffffff;stroke:none;stroke-width:0.694678;stroke-li=
necap:square;stroke-dasharray:4.16805, 4.16805"
> +       id=3D"rect1"
> +       width=3D"141.76276"
> +       height=3D"51.906979"
> +       x=3D"-23.062206"
> +       y=3D"30.75877" />
> +    <g
> +       id=3D"g28"
> +       transform=3D"matrix(1.0835493,0,0,1.0835493,-30.079831,-159.17628=
)">
> +      <path
> +         id=3D"path18"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g27">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path19"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path20"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path21"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path22"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path23"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path24"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path25"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path26"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path27"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path28"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path29"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path30"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.92107px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.434083"
> +       x=3D"23.133495"
> +       y=3D"52.750404"
> +       id=3D"text24"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"23.133495"
> +         y=3D"52.750404"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:3.92107px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff9955;stroke-width:0.434083"
> +         id=3D"tspan24">IB<tspan
> +   style=3D"font-size:3.92107px;baseline-shift:sub;fill:#ff9955;stroke-w=
idth:0.434083"
> +   id=3D"tspan27">b</tspan></tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.88054px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.434083"
> +       x=3D"2.4917324"
> +       y=3D"55.12072"
> +       id=3D"text139"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"2.4917324"
> +         y=3D"55.12072"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.88054px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.434083"
> +         id=3D"tspan138">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"2.4917324"
> +         y=3D"63.721394"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.88054px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.434083"
> +         id=3D"tspan139">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:3.92107px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.434083"
> +       x=3D"22.115709"
> +       y=3D"65.117416"
> +       id=3D"text18"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"22.115709"
> +         y=3D"65.117416"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:3.92107px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#87decd;stroke-width:0.434083"
> +         id=3D"tspan18">IB<tspan
> +   style=3D"font-size:3.92107px;baseline-shift:sub;fill:#87decd;stroke-w=
idth:0.434083"
> +   id=3D"tspan17">c</tspan></tspan></text>
> +    <g
> +       id=3D"g62"
> +       transform=3D"matrix(0.69467788,0,0,0.69467788,-104.6214,-57.02732=
4)">
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"221.50526"
> +         y=3D"173.96935"
> +         id=3D"text48"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"221.50526"
> +           y=3D"173.96935"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#37abc8;stroke-width:0.400612"
> +           id=3D"tspan48">SX</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"238.1783"
> +         y=3D"173.96935"
> +         id=3D"text49"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"238.1783"
> +           y=3D"173.96935"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#37abc8;stroke-width:0.400612"
> +           id=3D"tspan49">GE</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"255.66414"
> +         y=3D"173.96935"
> +         id=3D"text50"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"255.66414"
> +           y=3D"173.96935"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#37abc8;stroke-width:0.400612"
> +           id=3D"tspan50">SPI</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"273.01663"
> +         y=3D"173.96935"
> +         id=3D"text51"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"273.01663"
> +           y=3D"173.96935"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan51">SC</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"289.11816"
> +         y=3D"173.97888"
> +         id=3D"text52"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"289.11816"
> +           y=3D"173.97888"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan52">PA</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:6.35px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#ff2a2a;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"311.40778"
> +         y=3D"174.08365"
> +         id=3D"text53"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"311.40778"
> +           y=3D"174.08365"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#ff2a2a;stroke-width:0.400612"
> +           id=3D"tspan53">Cache</tspan></text>
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 226.31089,171.70241 h 6.95598"
> +         id=3D"path53"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 242.81883,171.70241 h 6.95598"
> +         id=3D"path54"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 261.37781,171.70241 h 6.95598"
> +         id=3D"path55"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 277.50475,171.70241 h 6.95598"
> +         id=3D"path56"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 294.08254,171.70241 h 6.95598"
> +         id=3D"path57"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 189.90312,171.70241 h 26.34385"
> +         id=3D"path60"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.529167;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Ar=
rowWideHeavy)"
> +         d=3D"m 311.60514,176.14239 v 9.61994 H 184.98772"
> +         id=3D"path61"
> +         sodipodi:nodetypes=3D"ccc" />
> +    </g>
> +    <path
> +       style=3D"fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke=
-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +       d=3D"m 40.698106,46.362333 4.844663,13.377322"
> +       id=3D"path62"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke=
-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +       d=3D"m 52.62426,46.362333 4.844663,13.377322"
> +       id=3D"path63"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke=
-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +       d=3D"m 64.55042,46.362333 4.844663,13.377322"
> +       id=3D"path64"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke=
-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +       d=3D"m 75.962512,46.362333 4.844663,13.377322"
> +       id=3D"path65"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke=
-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +       d=3D"m 87.580235,46.362333 4.844663,13.377322"
> +       id=3D"path66"
> +       sodipodi:nodetypes=3D"cc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.4112px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.278297"
> +       x=3D"37.018822"
> +       y=3D"45.730473"
> +       id=3D"text2"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"37.018822"
> +         y=3D"45.730473"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#37abc8;stroke-width:0.278297"
> +         id=3D"tspan2">SX</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.4112px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.278297"
> +       x=3D"48.601212"
> +       y=3D"45.730473"
> +       id=3D"text3"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"48.601212"
> +         y=3D"45.730473"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#37abc8;stroke-width:0.278297"
> +         id=3D"tspan3">GE</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.4112px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.278297"
> +       x=3D"60.748234"
> +       y=3D"45.730473"
> +       id=3D"text4"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"60.748234"
> +         y=3D"45.730473"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#37abc8;stroke-width:0.278297"
> +         id=3D"tspan4">SPI</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.4112px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.278297"
> +       x=3D"72.802635"
> +       y=3D"45.730473"
> +       id=3D"text11"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"72.802635"
> +         y=3D"45.730473"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.278297"
> +         id=3D"tspan11">SC</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.4112px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.278297"
> +       x=3D"83.988014"
> +       y=3D"45.737099"
> +       id=3D"text13"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"83.988014"
> +         y=3D"45.737099"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.278297"
> +         id=3D"tspan13">PA</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:4.4112px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#ff2a2a;fill-opacity:1;stroke:none;stroke-width:0.278297"
> +       x=3D"99.472122"
> +       y=3D"45.809875"
> +       id=3D"text14"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"99.472122"
> +         y=3D"45.809875"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#ff2a2a;stroke-width:0.278297"
> +         id=3D"tspan14">Cache</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 40.357179,44.155689 h 4.832165"
> +       id=3D"path44"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 51.82488,44.155689 h 4.832165"
> +       id=3D"path45"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 64.717393,44.155689 h 4.832165"
> +       id=3D"path46"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 75.920422,44.155689 h 4.832165"
> +       id=3D"path47"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 87.436645,44.155689 h 4.832166"
> +       id=3D"path48"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 24.215741,44.155689 h 7.813702"
> +       id=3D"path58"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#000000;stroke-width:0.367601;stroke-li=
necap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#Arro=
wWideHeavy)"
> +       d=3D"m 100.63732,46.931607 v 6.68276 H 29.848557"
> +       id=3D"path59"
> +       sodipodi:nodetypes=3D"ccc" />
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgp=
u/index.rst
> index bb2894b5edaf..1f0e8a38c625 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -8,6 +8,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) arc=
hitectures.
>  .. toctree::
>
>     driver-core
> +   ring-buffer
>     amd-hardware-list-info
>     module-parameters
>     gc/index
> diff --git a/Documentation/gpu/amdgpu/no_enforce_isolation.svg b/Document=
ation/gpu/amdgpu/no_enforce_isolation.svg
> new file mode 100644
> index 000000000000..38735447b005
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/no_enforce_isolation.svg
> @@ -0,0 +1,673 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"89.985634mm"
> +   height=3D"113.42541mm"
> +   viewBox=3D"0 0 89.985632 113.42541"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname=3D"no_enforce_isolation.svg"
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
> +     inkscape:zoom=3D"0.89386809"
> +     inkscape:cx=3D"649.42468"
> +     inkscape:cy=3D"584.53815"
> +     inkscape:window-width=3D"3072"
> +     inkscape:window-height=3D"1651"
> +     inkscape:window-x=3D"0"
> +     inkscape:window-y=3D"0"
> +     inkscape:window-maximized=3D"1"
> +     inkscape:current-layer=3D"g61" />
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
> +       id=3D"Dot"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Dot"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2=
.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes=3D"sssss"
> +         id=3D"path98" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"marker99"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Dot"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2=
.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes=3D"sssss"
> +         id=3D"path99" />
> +    </marker>
> +  </defs>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(72.009598,0.94510132)">
> +    <g
> +       id=3D"g61">
> +      <rect
> +         style=3D"fill:#ffffff;stroke:none;stroke-width:0.334811;stroke-=
linecap:square;stroke-dasharray:none"
> +         id=3D"rect6"
> +         width=3D"89.985634"
> +         height=3D"113.42541"
> +         x=3D"-72.009598"
> +         y=3D"-0.94510132" />
> +      <g
> +         id=3D"g15"
> +         transform=3D"matrix(0.55137703,0,0,0.55137703,-70.138056,-38.54=
6595)">
> +        <path
> +           id=3D"path33"
> +           style=3D"fill:none;stroke:#000000;stroke-width:0.721067;strok=
e-dasharray:none"
> +           d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737=
955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.90=
5334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537=
 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.7=
72359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.772=
46 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +        <g
> +           id=3D"g14">
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 46.31405,200.72093 h 6.430134"
> +             id=3D"path34"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 7.6848605,200.72093 H 14.114993"
> +             id=3D"path35"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 30.103415,176.7326 v 6.43014"
> +             id=3D"path36"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 30.103415,215.50586 V 221.936"
> +             id=3D"path37"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +             id=3D"path38"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +             id=3D"path39"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +             id=3D"path40"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +             id=3D"path41"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +             id=3D"path42"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +             id=3D"path43"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +             id=3D"path44-1"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +             id=3D"path45-8"
> +             sodipodi:nodetypes=3D"cc" />
> +        </g>
> +      </g>
> +      <rect
> +         style=3D"fill:#afe9c6;stroke:#16502d;stroke-width:0.335547;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +         id=3D"rect80"
> +         width=3D"32.727463"
> +         height=3D"13.694968"
> +         x=3D"-71.164459"
> +         y=3D"97.693985"
> +         ry=3D"1.8962265" />
> +      <rect
> +         style=3D"fill:#80e5ff;stroke:#00aad4;stroke-width:0.335547;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +         id=3D"rect81"
> +         width=3D"42.695518"
> +         height=3D"13.620045"
> +         x=3D"-30.862137"
> +         y=3D"97.731461"
> +         ry=3D"1.8858525" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:8.52288=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-55.04789"
> +         y=3D"107.58414"
> +         id=3D"text14-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-55.04789"
> +           y=3D"107.58414"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:8.52288px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan14-7">GFX</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:8.52288=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-9.8576069"
> +         y=3D"106.60402"
> +         id=3D"text95"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-9.8576069"
> +           y=3D"106.60402"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:8.52288px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan95">Compute</tspan></text>
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.503319;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -53.829112,96.73012 V 85.705707"
> +         id=3D"path127"
> +         sodipodi:nodetypes=3D"cc" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:3.78795=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-58.623249"
> +         y=3D"4.4640489"
> +         id=3D"text112"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-58.623249"
> +           y=3D"4.4640489"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:3.78795px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan112">Processes</tspan></text>
> +      <rect
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.322759;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:1.93655, 1.93655;stro=
ke-dashoffset:0"
> +         id=3D"rect113"
> +         width=3D"84.444534"
> +         height=3D"25.53046"
> +         x=3D"-67.463867"
> +         y=3D"6.1207871"
> +         ry=3D"2.2155666" />
> +      <g
> +         id=3D"g84"
> +         transform=3D"matrix(0.33554626,0,0,0.33554626,22.866079,11.7601=
36)">
> +        <g
> +           id=3D"g83">
> +          <circle
> +             style=3D"fill:#ffffff;stroke:#ff00ff;stroke-width:1.62704;s=
troke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-das=
hoffset:0"
> +             id=3D"circle137"
> +             cx=3D"-225.65012"
> +             cy=3D"20.747513"
> +             r=3D"30.822298" />
> +        </g>
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:16.93=
33px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-225.65012"
> +           y=3D"26.8181"
> +           id=3D"text113"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-225.65012"
> +             y=3D"26.8181"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#ff00ff;stroke-width:0.400612"
> +             id=3D"tspan113">A</tspan></text>
> +      </g>
> +      <g
> +         id=3D"g85"
> +         transform=3D"matrix(0.33554626,0,0,0.33554626,48.879283,11.7601=
36)">
> +        <circle
> +           style=3D"fill:#ffffff;stroke:#ff9955;stroke-width:1.62704;str=
oke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dasho=
ffset:0"
> +           id=3D"circle112"
> +           cx=3D"-207.94376"
> +           cy=3D"20.747513"
> +           r=3D"30.822298" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:16.93=
33px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-208.25702"
> +           y=3D"26.792702"
> +           id=3D"text114"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-208.25702"
> +             y=3D"26.792702"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#ff9955;stroke-width:0.400612"
> +             id=3D"tspan114">B</tspan></text>
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-51.280636"
> +         y=3D"61.904888"
> +         id=3D"text6"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-51.280636"
> +           y=3D"61.904888"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan6">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.95933=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-53.544945"
> +         y=3D"70.636482"
> +         id=3D"text136"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-53.544945"
> +           y=3D"70.636482"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.95933px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan136">Ring</tspan><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-53.544945"
> +           y=3D"74.335648"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.95933px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan137">Buffer</tspan></text>
> +      <g
> +         id=3D"g80"
> +         transform=3D"matrix(0.55137703,0,0,0.55137703,-26.59508,-38.546=
595)">
> +        <path
> +           id=3D"path67"
> +           style=3D"fill:none;stroke:#000000;stroke-width:0.721067;strok=
e-dasharray:none"
> +           d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737=
955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.90=
5334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537=
 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.7=
72359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.772=
46 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +        <g
> +           id=3D"g79">
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 46.31405,200.72093 h 6.430134"
> +             id=3D"path68"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 7.6848605,200.72093 H 14.114993"
> +             id=3D"path69"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 30.103415,176.7326 v 6.43014"
> +             id=3D"path70"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 30.103415,215.50586 V 221.936"
> +             id=3D"path71"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +             id=3D"path72"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +             id=3D"path73"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +             id=3D"path74"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +             id=3D"path75"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +             id=3D"path76"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +             id=3D"path77"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +             id=3D"path78"
> +             sodipodi:nodetypes=3D"cc" />
> +          <path
> +             style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +             d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +             id=3D"path79"
> +             sodipodi:nodetypes=3D"cc" />
> +        </g>
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.95933=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-10.001964"
> +         y=3D"70.636482"
> +         id=3D"text81"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-10.001964"
> +           y=3D"70.636482"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.95933px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan80">Ring</tspan><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-10.001964"
> +           y=3D"74.335648"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.95933px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan81">Buffer</tspan></text>
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.503319;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -9.7945204,96.73012 V 85.705707"
> +         id=3D"path81"
> +         sodipodi:nodetypes=3D"cc" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-43.566456"
> +         y=3D"76.071831"
> +         id=3D"text82"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-43.566456"
> +           y=3D"76.071831"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan82">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-43.167019"
> +         y=3D"69.279099"
> +         id=3D"text83"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-43.167019"
> +           y=3D"69.279099"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan83">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-16.592932"
> +         y=3D"80.848907"
> +         id=3D"text83-59"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-16.592932"
> +           y=3D"80.848907"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan83-7">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-2.9815638"
> +         y=3D"80.505638"
> +         id=3D"text83-59-3"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-2.9815638"
> +           y=3D"80.505638"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan83-7-6">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-51.195774"
> +         y=3D"82.70266"
> +         id=3D"text83-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-51.195774"
> +           y=3D"82.70266"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan83-8">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-60.216568"
> +         y=3D"80.730423"
> +         id=3D"text83-7-4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-60.216568"
> +           y=3D"80.730423"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff00ff;stroke-width:0.134424"
> +           id=3D"tspan83-8-3">A</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-46.846184"
> +         y=3D"64.185593"
> +         id=3D"text83-5"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-46.846184"
> +           y=3D"64.185593"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.134424"
> +           id=3D"tspan83-4">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-3.053925"
> +         y=3D"64.29808"
> +         id=3D"text83-5-9"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-3.053925"
> +           y=3D"64.29808"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.134424"
> +           id=3D"tspan83-4-2">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"0.39451206"
> +         y=3D"69.797745"
> +         id=3D"text83-5-9-9"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"0.39451206"
> +           y=3D"69.797745"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.134424"
> +           id=3D"tspan83-4-2-5">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"0.52325541"
> +         y=3D"75.869576"
> +         id=3D"text83-5-9-9-7"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"0.52325541"
> +           y=3D"75.869576"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff9955;stroke-width:0.134424"
> +           id=3D"tspan83-4-2-5-2">B</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-7.8769546"
> +         y=3D"82.812057"
> +         id=3D"text83-5-9-9-7-0"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-7.8769546"
> +           y=3D"82.812057"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff9955;stroke-width:0.134424"
> +           id=3D"tspan83-4-2-5-2-6">B</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-12.269638"
> +         y=3D"82.941895"
> +         id=3D"text83-5-9-9-7-0-4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-12.269638"
> +           y=3D"82.941895"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff9955;stroke-width:0.134424"
> +           id=3D"tspan83-4-2-5-2-6-9">B</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-46.911255"
> +         y=3D"80.618149"
> +         id=3D"text83-5-6"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-46.911255"
> +           y=3D"80.618149"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.134424"
> +           id=3D"tspan83-4-9">C</tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.84096=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-55.941418"
> +         y=3D"82.7742"
> +         id=3D"text83-5-6-5"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-55.941418"
> +           y=3D"82.7742"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.84096px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#ff0000;stroke-width:0.134424"
> +           id=3D"tspan83-4-9-2">C</tspan></text>
> +      <g
> +         id=3D"g86"
> +         transform=3D"matrix(0.33554626,0,0,0.33554626,44.707799,11.7601=
36)">
> +        <circle
> +           style=3D"fill:#ffffff;stroke:#ff0000;stroke-width:1.62704;str=
oke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dasho=
ffset:0"
> +           id=3D"circle84"
> +           cx=3D"-121.9205"
> +           cy=3D"20.747513"
> +           r=3D"30.822298" />
> +        <text
> +           xml:space=3D"preserve"
> +           style=3D"font-style:normal;font-weight:normal;font-size:16.93=
33px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacin=
g:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +           x=3D"-122.11524"
> +           y=3D"26.792702"
> +           id=3D"text84"><tspan
> +             sodipodi:role=3D"line"
> +             x=3D"-122.11524"
> +             y=3D"26.792702"
> +             style=3D"font-style:normal;font-variant:normal;font-weight:=
bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inksca=
pe-font-specification:'sans-serif Bold';text-align:center;text-anchor:middl=
e;fill:#ff0000;stroke-width:0.400612"
> +             id=3D"tspan84">C</tspan></text>
> +      </g>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-size:2.84096px;font-family:'Linux Libertine O';-i=
nkscape-font-specification:'Linux Libertine O';text-align:start;letter-spac=
ing:1.64864px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;=
stroke:#000000;stroke-width:0.335547;stroke-linecap:square;stroke-dasharray=
:none;stroke-dashoffset:0"
> +         x=3D"-160.78586"
> +         y=3D"34.318092"
> +         id=3D"text86"><tspan
> +           sodipodi:role=3D"line"
> +           id=3D"tspan86"
> +           style=3D"stroke-width:0.335547"
> +           x=3D"-160.78586"
> +           y=3D"34.318092" /></text>
> +      <rect
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.335547;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"rect86"
> +         width=3D"31.072945"
> +         height=3D"9.0205317"
> +         x=3D"-67.825142"
> +         y=3D"41.915016" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.60421=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-52.232677"
> +         y=3D"45.474743"
> +         id=3D"text88"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-52.232677"
> +           y=3D"45.474743"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.60421px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan2">Insert the Instruction</tspan><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-52.232677"
> +           y=3D"48.730003"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.60421px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan1">into the ring</tspan></text>
> +      <rect
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.335547;stroke-=
linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"rect89"
> +         width=3D"40.157963"
> +         height=3D"8.9755707"
> +         x=3D"-27.349821"
> +         y=3D"41.937496" />
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.503319;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -53.473992,57.398968 V 52.333823"
> +         id=3D"path90"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:#de8787;stroke:#000000;stroke-width:0.503319;stro=
ke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:=
url(#Dot);marker-end:url(#marker99)"
> +         d=3D"M -10.021017,57.398968 V 52.333823"
> +         id=3D"path91"
> +         sodipodi:nodetypes=3D"cc" />
> +      <path
> +         style=3D"fill:#ff00ff;stroke:#ff00ff;stroke-width:0.335547;stro=
ke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"M -52.849973,29.546839 V 41.564691"
> +         id=3D"path1" />
> +      <path
> +         style=3D"fill:#ff00ff;stroke:#ff9955;stroke-width:0.335547;stro=
ke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"M -20.895465,29.546839 V 41.564691"
> +         id=3D"path2" />
> +      <path
> +         style=3D"fill:#ff00ff;stroke:#ff0000;stroke-width:0.335547;stro=
ke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"M 3.7978311,29.546839 V 41.564691"
> +         id=3D"path4" />
> +      <path
> +         style=3D"fill:none;stroke:#ff00ff;stroke-width:0.335547;stroke-=
linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m -52.849973,29.546839 v 6.753833 h 27.213977 v 5.264019"
> +         id=3D"path5"
> +         sodipodi:nodetypes=3D"cccc" />
> +      <path
> +         style=3D"fill:none;stroke:#ff0000;stroke-width:0.335547;stroke-=
linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
> +         d=3D"m 3.7978311,29.546839 v 4.767412 H -41.590279 v 7.25044"
> +         id=3D"path6"
> +         sodipodi:nodetypes=3D"cccc" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:2.60421=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.134424"
> +         x=3D"-7.2148504"
> +         y=3D"45.474747"
> +         id=3D"text4"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-7.2148509"
> +           y=3D"45.474747"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.60421px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan3">Insert the Instruction</tspan><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-7.2148504"
> +           y=3D"48.730011"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:2.60421px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.134424"
> +           id=3D"tspan4">into the ring</tspan></text>
> +    </g>
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/ring-buffer.rst b/Documentation/gpu=
/amdgpu/ring-buffer.rst
> new file mode 100644
> index 000000000000..40c189c9dab4
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/ring-buffer.rst
> @@ -0,0 +1,94 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + Ring Buffer
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To handle communication between user space and kernel space, amdgpu adop=
ts a
> +strategy based on a ring buffer, which is used by GFX, Compute, SDMA, UV=
D, VCE,
> +VCN, VPE, KIQ, MES, UMSCH, and CPER. See the figure below that illustrat=
es how
> +this communication works:
> +
> +.. kernel-figure:: ring_buffers.svg
> +
> +Ring buffers in the amdgpu work as a producer-consumer problem, where us=
erspace
> +acts as the producer, constantly filling the ring buffer with GPU comman=
ds to
> +be executed. Meanwhile, the GPU retrieves the information from the ring,=
 parses
> +it, and distributes the specific set of instructions between the differe=
nt
> +amdgpu blocks. Notice from the diagram that the ring has a Read Pointer =
(rptr)
> +that indicates where the GPU is currently reading, and there is a Write =
Pointer
> +(wptr) that indicates where the host has written the message. Note that =
every
> +time something is written to the ring, the wptr is incremented. Meanwhil=
e, the
> +GPU constantly updates the rptr pointer, chasing the wptr until both poi=
nters
> +are equal. The user space or the driver can utilize the rptr pointer to =
roughly

User space or the driver

> +estimate how many instructions are still pending completion (keep in min=
d that
> +rptr might not be precise).

You might want to drop the comment in the paranthesis.  If you read
back the actual
rptr register, it should be correct, but the driver generally uses a
rptr shadow in memory which the engine may only update periodically.

> +
> +Usually, ring buffers in the driver have a limited size (search for occu=
rrences
> +of `amdgpu_ring_init()`). One of the reasons for the small ring buffer s=
ize is
> +that CP (Command Processor) is capable of following addresses inserted i=
nto the
> +ring; this is illustrated in the image by the reference to the IB (Indir=
ect
> +Buffer). The IB gives userspace the possibility to have an area in memor=
y that
> +CP can read and feed the hardware with extra instructions.
> +
> +Enforce Isolation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Before examining the Enforce Isolation mechanism in the ring buffer cont=
ext, it
> +is important to discuss two concepts: where the ring buffer is located a=
nd how
> +instructions from the ring buffer are processed in the graphics pipeline=
.
> +
> +All ASICs pre-GFX11 use what is called a kernel queue, which means the r=
ing is

gfx11 and 12 still use kernel queues, they just happen to also support
user queues.

> +allocated in kernel space and has some restrictions, such as not being a=
ble to
> +map and unmap queues after initialization. GFX12 and newer support kerne=
l

Kernel queues can be mapped an unmapped, the scheduler just never preempts =
them.

> +queues, but also provide a new mechanism named user queues, where the qu=
eue is
> +moved to the user space and can be mapped and unmapped. In practical ter=
ms, the
> +kernel queue approach inserts all GPU commands created by userspace into=
 the
> +same set of rings, albeit in a mixed manner. See the picture below illus=
trating
> +this scenario:
> +
> +.. kernel-figure:: no_enforce_isolation.svg
> +
> +Note from the diagram that there is no guarantee of order or a clear sep=
aration
> +between instructions, which is not a problem most of the time, and this =
is also

I haven't looked at the images yet, but the jobs are added
sequentially, it's just that because the GC engine is pipelined, you
can have multiple things overlapping.

> +good for performance. In terms of executing those instructions in the GF=
X, it
> +must follow a pipeline that usually follows the following sequence: Shad=
er
> +Export (SX), Geometry Engine (GE), Shader Process or Input (SPI), Scan
> +Converter (SC), Primitive Assembler (PA), and cache manipulation (this m=
ay
> +change between ASICs). Another common way to describe the pipeline is to=
 use
> +Pixel Shader (PS), raster, and Vertex Shader (VS) to symbolize the two s=
hader
> +stages. The diagram below illustrates the sequence described in the para=
graph.

I think the rest of this paragraph is unrelated to enforce isolation.
I think it should be moved somewhere else to describe the hardware
pipeline.

> +
> +.. kernel-figure:: gfx_pipeline_seq.svg
> +
> +The use of the kernel queue is the default behaviour in amdgpu pre-GFX11=
 and in
> +many cases in newer ASICs. Although this solution is considered stable a=
nd
> +performs well, it also creates some intricate issues when something goes=
 wrong.
> +The problem with this solution is that pinpointing which job caused an i=
ssue
> +can be challenging in some situations, which can complicate the debuggin=
g in
> +circumstances where the GPU recovery was triggered. For instance, if Job=
 A
> +causes a hang issue, Job B's instruction might already be executing, and=
 we
> +could incorrectly identify Job B as the problematic one. To mitigate thi=
s
> +problem, it was introduced the concept of Enforce Isolation that can be =
seen in
> +the below picture:
> +
> +.. kernel-figure:: enforce_isolation.svg
> +
> +As shown in the diagram, enforcing isolation introduces a level of order=
ing
> +between submissions, since the access to GFX/Compute is serialized. Noti=
ce that
> +this approach has a minimal performance impact, as it only allows one jo=
b to
> +submit commands at a time. However, this is not a notable problem, and t=
he
> +benefit of better pinpointing the job that caused a problem outweighs th=
e
> +performance impact. Although enforcing isolation improves the situation,=
 it
> +does not fully resolve the issue of pinpointing bad jobs, as we can stil=
l
> +encounter scenarios where Job A hangs while Job B is running, leading to=
 the
> +wrong blame of Job B. To avoid this issue, an additional element is intr=
oduced
> +to enforce isolation, as represented by the circles in the diagram. Ever=
y
> +circle is a wait for cache flushing, which ensures that when the next jo=
b
> +starts, it starts in a clean state, and if some issues happen, we can po=
int to
> +the bad process more precisely.

I haven't seen the diagram yet, but this doesn't sound completely
correct.  The driver inserts a fence wait between jobs in each ring to
make sure there is no overlapping work in the ring itself.  However,
that is independent of enforce isolation.  If you enable enforce
isolation, all jobs going to all GC queues are serialized.

Alex

> +
> +Ring Operations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +   :internal:
> +
> diff --git a/Documentation/gpu/amdgpu/ring_buffers.svg b/Documentation/gp=
u/amdgpu/ring_buffers.svg
> new file mode 100644
> index 000000000000..7a6fcb19e151
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/ring_buffers.svg
> @@ -0,0 +1,1633 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width=3D"588.32483mm"
> +   height=3D"341.81656mm"
> +   viewBox=3D"0 0 588.32483 341.81656"
> +   version=3D"1.1"
> +   id=3D"svg1"
> +   inkscape:version=3D"1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname=3D"RING_BUFFER.svg"
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
> +     inkscape:zoom=3D"0.89386809"
> +     inkscape:cx=3D"1106.9866"
> +     inkscape:cy=3D"729.97348"
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
> +       id=3D"marker154"
> +       refX=3D"2"
> +       refY=3D"0"
> +       orient=3D"auto-start-reverse"
> +       inkscape:stockid=3D"Empty semicircle"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         style=3D"fill:none;fill-rule:evenodd;stroke:context-stroke;stro=
ke-width:1.08"
> +         d=3D"m -0.7647042,-3.0274156 c 1.656,0 3,1.344 3,3 0,1.656 -1.3=
44,3 -3,3"
> +         id=3D"path154" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"ArrowTriangleStylized"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto-start-reverse"
> +       inkscape:stockid=3D"Stylized triangle arrow"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:context-s=
troke;stroke-width:1pt"
> +         d=3D"m 6,0 c -3,1 -7,3 -9,5 0,0 0,-4 2,-5 -2,-1 -2,-5 -2,-5 2,2=
 6,4 9,5 z"
> +         id=3D"path135" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"marker132"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Diamond"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.45)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 0,-7.0710768 -7.0710894,0 0,7.0710589 7.0710462,0 Z"
> +         id=3D"path132" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"Diamond"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Diamond"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.45)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 0,-7.0710768 -7.0710894,0 0,7.0710589 7.0710462,0 Z"
> +         id=3D"path131" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"ArrowWide"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto-start-reverse"
> +       inkscape:stockid=3D"Wide arrow"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         style=3D"fill:none;stroke:context-stroke;stroke-width:1;stroke-=
linecap:butt"
> +         d=3D"M 3,-3 0,0 3,3"
> +         transform=3D"rotate(180,0.125,0)"
> +         sodipodi:nodetypes=3D"ccc"
> +         id=3D"path81" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"marker99"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Dot"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2=
.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes=3D"sssss"
> +         id=3D"path99" />
> +    </marker>
> +    <marker
> +       style=3D"overflow:visible"
> +       id=3D"Dot"
> +       refX=3D"0"
> +       refY=3D"0"
> +       orient=3D"auto"
> +       inkscape:stockid=3D"Dot"
> +       markerWidth=3D"1"
> +       markerHeight=3D"1"
> +       viewBox=3D"0 0 1 1"
> +       inkscape:isstock=3D"true"
> +       inkscape:collect=3D"always"
> +       preserveAspectRatio=3D"xMidYMid">
> +      <path
> +         transform=3D"scale(0.5)"
> +         style=3D"fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d=3D"M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2=
.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
> +         sodipodi:nodetypes=3D"sssss"
> +         id=3D"path98" />
> +    </marker>
> +  </defs>
> +  <g
> +     inkscape:label=3D"Layer 1"
> +     inkscape:groupmode=3D"layer"
> +     id=3D"layer1"
> +     transform=3D"translate(123.51219,3.0159921)">
> +    <rect
> +       style=3D"fill:#ffffff;stroke:none;stroke-width:1;stroke-linecap:s=
quare;stroke-dasharray:1, 2;stroke-dashoffset:0"
> +       id=3D"rect167"
> +       width=3D"595.25238"
> +       height=3D"349.86984"
> +       x=3D"-128.24815"
> +       y=3D"-8.0479612" />
> +    <rect
> +       style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:1, 2;stroke-dashoffset:0"
> +       id=3D"rect111"
> +       width=3D"500.64935"
> +       height=3D"63.365536"
> +       x=3D"-65.219322"
> +       y=3D"168.41347"
> +       ry=3D"5.4989429" />
> +    <path
> +       style=3D"fill:none;stroke:#917c6f;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 24.09216,175.30492 V 125.06784 H 47.447018 V 83.98949"
> +       id=3D"path151"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <g
> +       id=3D"g15"
> +       transform=3D"translate(-4.735971)">
> +      <path
> +         id=3D"path1"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g14">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path3"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path4"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path5"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path6"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path7"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path8"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path9"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path10"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path11"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path12"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path13"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path14"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <g
> +       id=3D"g28"
> +       transform=3D"translate(46.175717)">
> +      <path
> +         id=3D"path15"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g27">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path16"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path17"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path18"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path19"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path20"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path21"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path22"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path23"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path24"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path25"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path26"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path27"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <g
> +       id=3D"g41"
> +       transform=3D"translate(102.62407)">
> +      <path
> +         id=3D"path28"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g40">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path29"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path30"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path31"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path32"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path33"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path34"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path35"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path36"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path37"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path38"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path39"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path40"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <g
> +       id=3D"g54"
> +       transform=3D"translate(154.12775)">
> +      <path
> +         id=3D"path41"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g53">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path42"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path43"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path44"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path45"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path46"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path47"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path48"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path49"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path50"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path51"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path52"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path53"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <g
> +       id=3D"g67"
> +       transform=3D"translate(205.37341)">
> +      <path
> +         id=3D"path54"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g66">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path55"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path56"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path57"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path58"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path59"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path60"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path61"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path62"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path63"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path64"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path65"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path66"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <g
> +       id=3D"g80"
> +       transform=3D"translate(256.63043)">
> +      <path
> +         id=3D"path67"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g79">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path68"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path69"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path70"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path71"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path72"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path73"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path74"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path75"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path76"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path77"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path78"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path79"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <rect
> +       style=3D"fill:#afe9c6;stroke:#16502d;stroke-width:1;stroke-lineca=
p:square;stroke-linejoin:miter;stroke-dasharray:none"
> +       id=3D"rect80"
> +       width=3D"97.534882"
> +       height=3D"40.813953"
> +       x=3D"2.9731095"
> +       y=3D"288.36279"
> +       ry=3D"5.6511626" />
> +    <rect
> +       style=3D"fill:#80e5ff;stroke:#00aad4;stroke-width:1;stroke-lineca=
p:square;stroke-linejoin:miter;stroke-dasharray:none"
> +       id=3D"rect81"
> +       width=3D"199.46111"
> +       height=3D"40.391335"
> +       x=3D"110.41494"
> +       y=3D"288.57413"
> +       ry=3D"5.5926461" />
> +    <rect
> +       style=3D"fill:#de8787;stroke:#a02c2c;stroke-width:1;stroke-lineca=
p:square;stroke-linejoin:miter;stroke-dasharray:none"
> +       id=3D"rect82"
> +       width=3D"81.028717"
> +       height=3D"40.88369"
> +       x=3D"321.87186"
> +       y=3D"288.32794"
> +       ry=3D"5.6608181" />
> +    <g
> +       id=3D"g95"
> +       transform=3D"translate(332.1071)">
> +      <path
> +         id=3D"path82"
> +         style=3D"fill:none;stroke:#000000;stroke-width:0.721067;stroke-=
dasharray:none"
> +         d=3D"M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.373795=
5,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.9053=
34 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z=
 m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772=
359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246=
 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
> +      <g
> +         id=3D"g94">
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 46.31405,200.72093 h 6.430134"
> +           id=3D"path83"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 7.6848605,200.72093 H 14.114993"
> +           id=3D"path84"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 30.103415,176.7326 v 6.43014"
> +           id=3D"path85"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 30.103415,215.50586 V 221.936"
> +           id=3D"path86"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,214.1052 3.21507,5.56866"
> +           id=3D"path87"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 36.501694,184.66805 3.21507,-5.56866"
> +           id=3D"path88"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,184.66805 -3.21507,-5.56866"
> +           id=3D"path89"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 23.652811,214.05288 -3.21507,5.56866"
> +           id=3D"path90"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,208.65101 4.546794,4.5468"
> +           id=3D"path91"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 43.31839,189.96525 4.546794,-4.5468"
> +           id=3D"path92"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"M 17.202394,189.96525 12.6556,185.41845"
> +           id=3D"path93"
> +           sodipodi:nodetypes=3D"cc" />
> +        <path
> +           style=3D"fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-li=
necap:square;stroke-linejoin:miter;stroke-dasharray:none"
> +           d=3D"m 16.940766,208.65101 -4.546794,4.5468"
> +           id=3D"path94"
> +           sodipodi:nodetypes=3D"cc" />
> +      </g>
> +    </g>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:25.4px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"51.003948"
> +       y=3D"317.83759"
> +       id=3D"text14-7"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"51.003948"
> +         y=3D"317.83759"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:25.4px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan14-7">GFX</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:25.4px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"209.95499"
> +       y=3D"314.9166"
> +       id=3D"text95"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"209.95499"
> +         y=3D"314.9166"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:25.4px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan95">Compute</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:25.4px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"361.80203"
> +       y=3D"317.83759"
> +       id=3D"text96"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"361.80203"
> +         y=3D"317.83759"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:25.4px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan96">SDMA</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:36.862px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"429.28961"
> +       y=3D"313.10159"
> +       id=3D"text97"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"429.28961"
> +         y=3D"313.10159"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan97">...</tspan></text>
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 25.543152,285.49025 V 224.58863"
> +       id=3D"path97"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 76.45484,285.49025 V 224.58863"
> +       id=3D"path100"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 132.90319,285.49025 V 224.58863"
> +       id=3D"path101"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 184.40687,285.49025 V 224.58863"
> +       id=3D"path102"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 235.65253,285.49025 V 224.58863"
> +       id=3D"path103"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 286.90955,285.49025 V 224.58863"
> +       id=3D"path104"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-line=
cap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Do=
t);marker-end:url(#marker99)"
> +       d=3D"M 362.38622,285.49025 V 224.58863"
> +       id=3D"path105"
> +       sodipodi:nodetypes=3D"cc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:36.862px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"261.28104"
> +       y=3D"259.52591"
> +       id=3D"text105"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"261.28104"
> +         y=3D"259.52591"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan105">...</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:36.862px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"50.998993"
> +       y=3D"259.52591"
> +       id=3D"text106"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"50.998993"
> +         y=3D"259.52591"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan106">...</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:36.862px;=
line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px=
;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"382.22592"
> +       y=3D"259.52591"
> +       id=3D"text107"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"382.22592"
> +         y=3D"259.52591"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-fo=
nt-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fil=
l:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan107">...</tspan></text>
> +    <path
> +       style=3D"fill:#de8787;stroke:#000000;stroke-width:2;stroke-lineca=
p:square;stroke-linejoin:miter;stroke-dasharray:none"
> +       d=3D"M -65.568535,148.88709 H 459.54211"
> +       id=3D"path107" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:19.7556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"415.21619"
> +       y=3D"166.24187"
> +       id=3D"text108"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"415.21619"
> +         y=3D"166.24187"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:19.7556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan108">Kernel</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:19.7556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"414.91986"
> +       y=3D"138.75868"
> +       id=3D"text109"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"414.91986"
> +         y=3D"138.75868"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:19.7556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan109">Userspace</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:11.2889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"-44.396496"
> +       y=3D"199.94142"
> +       id=3D"text110"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-44.396496"
> +         y=3D"199.94142"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan110">Kernel</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-44.396496"
> +         y=3D"214.05255"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan111">Queue</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:11.2889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"-30.39555"
> +       y=3D"53.215206"
> +       id=3D"text112"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-30.39555"
> +         y=3D"53.215206"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan112">Processes</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#000000;stroke-width:1.5;stroke-linecap=
:square;stroke-linejoin:miter;stroke-dasharray:9, 9;stroke-dashoffset:0"
> +       id=3D"rect113"
> +       width=3D"452.2225"
> +       height=3D"75.723717"
> +       x=3D"-60.944237"
> +       y=3D"11.868809"
> +       ry=3D"6.5714021" />
> +    <circle
> +       style=3D"fill:#ffffff;stroke:#917c6f;stroke-width:1.62704;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffse=
t:0"
> +       id=3D"path111"
> +       cx=3D"47.507706"
> +       cy=3D"49.241512"
> +       r=3D"30.822298" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:16.9333px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#917c6f;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"47.50771"
> +       y=3D"55.312099"
> +       id=3D"text113"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"47.50771"
> +         y=3D"55.312099"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#917c6f;stroke-width:0.400612"
> +         id=3D"tspan113">A</tspan></text>
> +    <circle
> +       style=3D"fill:#ffffff;stroke:#ff9955;stroke-width:1.62704;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffse=
t:0"
> +       id=3D"circle112"
> +       cx=3D"176.56291"
> +       cy=3D"49.241512"
> +       r=3D"30.822298" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:16.9333px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"176.24965"
> +       y=3D"55.286701"
> +       id=3D"text114"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"176.24965"
> +         y=3D"55.286701"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff9955;stroke-width:0.400612"
> +         id=3D"tspan114">B</tspan></text>
> +    <circle
> +       style=3D"fill:#ffffff;stroke:#55ddff;stroke-width:1.62704;stroke-=
linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffse=
t:0"
> +       id=3D"circle113"
> +       cx=3D"305.61813"
> +       cy=3D"49.241512"
> +       r=3D"30.822298" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:16.9333px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"305.42337"
> +       y=3D"55.286701"
> +       id=3D"text115"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"305.42337"
> +         y=3D"55.286701"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#55ddff;stroke-width:0.400612"
> +         id=3D"tspan115">C</tspan></text>
> +    <rect
> +       style=3D"fill:none;stroke:#000000;stroke-width:1.5;stroke-linecap=
:square;stroke-linejoin:miter;stroke-dasharray:5.99998, 2.99999, 1.5, 2.999=
99;stroke-dashoffset:0"
> +       id=3D"rect117"
> +       width=3D"515.65753"
> +       height=3D"59.528286"
> +       x=3D"-65.221695"
> +       y=3D"278.51898"
> +       ry=3D"5.1659417" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:11.2889px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"-44.396496"
> +       y=3D"312.30948"
> +       id=3D"text118"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-44.396496"
> +         y=3D"312.30948"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan118">GPU</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"-17.792967"
> +       y=3D"194.41469"
> +       id=3D"text4"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-17.792967"
> +         y=3D"194.41469"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff0000;stroke-width:0.400612"
> +         id=3D"tspan4">wptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"36.248669"
> +       y=3D"163.10979"
> +       id=3D"text5"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"36.248669"
> +         y=3D"163.10979"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#00ff00;stroke-width:0.400612"
> +         id=3D"tspan5">rptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"28.952087"
> +       y=3D"182.41843"
> +       id=3D"text6"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"28.952087"
> +         y=3D"182.41843"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ac9d93;stroke-width:0.400612"
> +         id=3D"tspan6">A</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"37.832031"
> +       y=3D"186.1924"
> +       id=3D"text7"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"37.832031"
> +         y=3D"186.1924"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ac9d93;stroke-width:0.400612"
> +         id=3D"tspan7">A</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"37.98003"
> +       y=3D"216.31021"
> +       id=3D"text8"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"37.98003"
> +         y=3D"216.31021"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ac9d93;stroke-width:0.400612"
> +         id=3D"tspan8">A</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"8.1582127"
> +       y=3D"208.54025"
> +       id=3D"text9"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"8.1582127"
> +         y=3D"208.54025"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ac9d93;stroke-width:0.400612"
> +         id=3D"tspan9">A</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"114.03775"
> +       y=3D"196.40289"
> +       id=3D"text10"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"114.03775"
> +         y=3D"196.40289"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ac9d93;stroke-width:0.400612"
> +         id=3D"tspan10">A</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"366.5202"
> +       y=3D"220.80096"
> +       id=3D"text11"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"366.5202"
> +         y=3D"220.80096"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ac9d93;stroke-width:0.400612"
> +         id=3D"tspan11">A</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"95.389114"
> +       y=3D"196.60231"
> +       id=3D"text12"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"95.389114"
> +         y=3D"196.60231"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan12">B</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"171.62987"
> +       y=3D"186.67509"
> +       id=3D"text13"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"171.62987"
> +         y=3D"186.67509"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan13">B</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"358.23288"
> +       y=3D"220.44789"
> +       id=3D"text14"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"358.23288"
> +         y=3D"220.44789"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan14">B</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"94.24794"
> +       y=3D"208.68309"
> +       id=3D"text15"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"94.24794"
> +         y=3D"208.68309"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#55ddff;stroke-width:0.400612"
> +         id=3D"tspan15">C</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"43.869183"
> +       y=3D"196.65234"
> +       id=3D"text16"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"43.869183"
> +         y=3D"196.65234"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#55ddff;stroke-width:0.400612"
> +         id=3D"tspan16">C</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#00ccff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"188.07849"
> +       y=3D"181.51845"
> +       id=3D"text17"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"188.07849"
> +         y=3D"181.51845"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#00ccff;stroke-width:0.400612"
> +         id=3D"tspan17"><tspan
> +           style=3D"font-size:4.93889px;fill:#00ccff"
> +           id=3D"tspan26">IB</tspan><tspan
> +           style=3D"font-size:3.52778px;baseline-shift:sub;fill:#00ccff"
> +           id=3D"tspan25">c</tspan></tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"349.12769"
> +       y=3D"216.0551"
> +       id=3D"text18"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"349.12769"
> +         y=3D"216.0551"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#55ddff;stroke-width:0.400612"
> +         id=3D"tspan18">C</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"43.394695"
> +       y=3D"208.58258"
> +       id=3D"text19"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"43.394695"
> +         y=3D"208.58258"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan19">B</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"29.580742"
> +       y=3D"220.72212"
> +       id=3D"text20"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"29.580742"
> +         y=3D"220.72212"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan20">B</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"13.045858"
> +       y=3D"216.32677"
> +       id=3D"text21"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"13.045858"
> +         y=3D"216.32677"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan21">B</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"21.055231"
> +       y=3D"220.72211"
> +       id=3D"text22"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"21.055231"
> +         y=3D"220.72211"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#55ddff;stroke-width:0.400612"
> +         id=3D"tspan22">C</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"179.01208"
> +       y=3D"182.54855"
> +       id=3D"text23"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"179.01208"
> +         y=3D"182.54855"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#55ddff;stroke-width:0.400612"
> +         id=3D"tspan23">C</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"88.379082"
> +       y=3D"185.52925"
> +       id=3D"text24"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"88.379082"
> +         y=3D"185.52925"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan24"><tspan
> +           style=3D"font-size:4.93889px;fill:#ff9955"
> +           id=3D"tspan28">IB</tspan><tspan
> +           style=3D"font-size:3.52778px;baseline-shift:sub;fill:#ff9955"
> +           id=3D"tspan27">b</tspan></tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"97.027405"
> +       y=3D"163.10979"
> +       id=3D"text29"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"97.027405"
> +         y=3D"163.10979"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#00ff00;stroke-width:0.400612"
> +         id=3D"tspan29">rptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"102.24193"
> +       y=3D"229.5128"
> +       id=3D"text30"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"102.24193"
> +         y=3D"229.5128"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff0000;stroke-width:0.400612"
> +         id=3D"tspan30">wptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"116.89307"
> +       y=3D"163.58255"
> +       id=3D"text31"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"116.89307"
> +         y=3D"163.58255"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff0000;stroke-width:0.400612"
> +         id=3D"tspan31">wptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"104.55666"
> +       y=3D"178.91209"
> +       id=3D"text32"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"104.55666"
> +         y=3D"178.91209"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#00ff00;stroke-width:0.400612"
> +         id=3D"tspan32">rptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"169.33571"
> +       y=3D"163.10979"
> +       id=3D"text33"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"169.33571"
> +         y=3D"163.10979"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#00ff00;stroke-width:0.400612"
> +         id=3D"tspan33">rptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"198.10239"
> +       y=3D"164.21048"
> +       id=3D"text34"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"198.10239"
> +         y=3D"164.21048"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff0000;stroke-width:0.400612"
> +         id=3D"tspan34">wptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"321.48608"
> +       y=3D"209.17052"
> +       id=3D"text35"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"321.48608"
> +         y=3D"209.17052"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#ff0000;stroke-width:0.400612"
> +         id=3D"tspan35">wptr</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.05556px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"381.35901"
> +       y=3D"239.92375"
> +       id=3D"text36"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"381.35901"
> +         y=3D"239.92375"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#00ff00;stroke-width:0.400612"
> +         id=3D"tspan36">rptr</tspan></text>
> +    <path
> +       style=3D"fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m 35.624746,164.89008 -2.762741,10.3107"
> +       id=3D"path80" />
> +    <path
> +       style=3D"fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m -8.7253214,192.92597 h 10.67442"
> +       id=3D"path95" />
> +    <path
> +       style=3D"fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"M 96.12886,165.61875 92.526458,179.0631"
> +       id=3D"path96"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m 99.252771,223.75691 -6.710739,-5.14099"
> +       id=3D"path106"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:none;stroke:#00ff00;stroke-width:1;stroke-linecap:s=
quare;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
> +       d=3D"m 104.23449,180.8622 v 13.29071 h 4.91861"
> +       id=3D"path108"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m 117.92183,166.63928 v 12.97675"
> +       id=3D"path109"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m 198.50323,166.63928 v 12.97675"
> +       id=3D"path110"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m 169.22285,165.37383 v 13.91861"
> +       id=3D"path112"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"m 379.21241,233.73729 -9.84194,-9.84195"
> +       id=3D"path113"
> +       sodipodi:nodetypes=3D"cc" />
> +    <path
> +       style=3D"fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-lineca=
p:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWid=
e)"
> +       d=3D"M 330.44909,207.68179 H 340.077"
> +       id=3D"path114"
> +       sodipodi:nodetypes=3D"cc" />
> +    <g
> +       id=3D"g127"
> +       transform=3D"translate(-243.31051,23.087859)">
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.76111=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"135.71123"
> +         y=3D"112.41485"
> +         id=3D"text116"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"135.71123"
> +           y=3D"112.41485"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan116">PM4<tspan
> +   style=3D"font-size:65%;baseline-shift:sub"
> +   id=3D"tspan117">1</tspan></tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.76111=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"135.39342"
> +         y=3D"122.44057"
> +         id=3D"text120"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"135.39342"
> +           y=3D"122.44057"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan120">PM4<tspan
> +   style=3D"font-size:65%;baseline-shift:sub"
> +   id=3D"tspan123">2</tspan></tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.76111=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"135.49934"
> +         y=3D"136.68669"
> +         id=3D"text122"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"135.49934"
> +           y=3D"136.68669"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan122">PM4<tspan
> +   style=3D"font-size:65%;baseline-shift:sub"
> +   id=3D"tspan124">n</tspan></tspan></text>
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:7.76111=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"135.65942"
> +         y=3D"128.1123"
> +         id=3D"text126"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"135.65942"
> +           y=3D"128.1123"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan126">...</tspan></text>
> +      <path
> +         style=3D"fill:none;stroke:#0000ff;stroke-width:2;stroke-linecap=
:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         d=3D"m 126.12628,103.17346 h -5.32796 v 38.77576 h 5.32796"
> +         id=3D"path126"
> +         sodipodi:nodetypes=3D"cccc" />
> +      <path
> +         style=3D"fill:none;stroke:#0000ff;stroke-width:2;stroke-linecap=
:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         d=3D"m 143.29418,103.17346 h 5.32796 v 38.77576 h -5.32796"
> +         id=3D"path127"
> +         sodipodi:nodetypes=3D"cccc" />
> +    </g>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"-7.0803289"
> +       y=3D"244.43291"
> +       id=3D"text129"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-7.0803289"
> +         y=3D"244.43291"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#ff9955;stroke-width:0.400612"
> +         id=3D"tspan129"><tspan
> +           style=3D"font-size:7.05556px;fill:#ff9955"
> +           id=3D"tspan127">IB</tspan><tspan
> +           style=3D"font-size:3.52778px;baseline-shift:sub;fill:#ff9955"
> +           id=3D"tspan128">b</tspan></tspan></text>
> +    <g
> +       id=3D"g130"
> +       transform=3D"translate(-0.5919954,-90.131448)">
> +      <rect
> +         style=3D"fill:#ffff00;stroke:#ffff00;stroke-width:0.743523;stro=
ke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
> +         id=3D"rect130"
> +         width=3D"16.584557"
> +         height=3D"11.616416"
> +         x=3D"-21.840757"
> +         y=3D"358.62256"
> +         ry=3D"0" />
> +      <text
> +         xml:space=3D"preserve"
> +         style=3D"font-style:normal;font-weight:normal;font-size:9.87778=
px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:=
0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +         x=3D"-13.612684"
> +         y=3D"367.95712"
> +         id=3D"text130"><tspan
> +           sodipodi:role=3D"line"
> +           x=3D"-13.612684"
> +           y=3D"367.95712"
> +           style=3D"font-style:normal;font-variant:normal;font-weight:bo=
ld;font-stretch:normal;font-size:9.87778px;font-family:sans-serif;-inkscape=
-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;=
fill:#1c241c;stroke-width:0.400612"
> +           id=3D"tspan130">CP</tspan></text>
> +    </g>
> +    <path
> +       style=3D"fill:none;stroke:#00d4aa;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
32);marker-end:url(#Diamond)"
> +       d=3D"M -13.431733,265.14038 V 238.02343 H 76.45484"
> +       id=3D"path130"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#00d4aa;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
32);marker-end:url(#Diamond)"
> +       d=3D"m -108.62977,169.16297 v 103.37737 h 82.669238"
> +       id=3D"path133"
> +       sodipodi:nodetypes=3D"ccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ff0000;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#ArrowTr=
iangleStylized)"
> +       d=3D"M -107.14978,120.98926 V -2.5159921 H 176.92597 V 16.131894"
> +       id=3D"path134"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"25.324078"
> +       y=3D"197.77319"
> +       id=3D"text136"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"25.324078"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan136">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"25.324078"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan137">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"76.235764"
> +       y=3D"197.77319"
> +       id=3D"text139"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"76.235764"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan138">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"76.235764"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan139">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"132.68411"
> +       y=3D"197.77319"
> +       id=3D"text141"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"132.68411"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan140">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"132.68411"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan141">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"184.18781"
> +       y=3D"197.77319"
> +       id=3D"text143"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"184.18781"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan142">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"184.18781"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan143">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"235.43346"
> +       y=3D"197.77319"
> +       id=3D"text147"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"235.43346"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan146">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"235.43346"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan147">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"286.69049"
> +       y=3D"197.77319"
> +       id=3D"text149"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"286.69049"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan148">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"286.69049"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan149">Buffer</tspan></text>
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:6.35px;li=
ne-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;f=
ill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"362.16714"
> +       y=3D"197.77319"
> +       id=3D"text151"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"362.16714"
> +         y=3D"197.77319"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan150">Ring</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"362.16714"
> +         y=3D"205.71069"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font=
-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:=
#1c241c;stroke-width:0.400612"
> +         id=3D"tspan151">Buffer</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#917c6f;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 134.065,175.23092 V 125.06784 H 47.638527 V 89.317459"
> +       id=3D"path158"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#917c6f;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 365.79312,175.67492 V 125.06784 H 47.447018 V 81.621506"
> +       id=3D"path159"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <text
> +       xml:space=3D"preserve"
> +       style=3D"font-style:normal;font-weight:normal;font-size:7.76111px=
;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0p=
x;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
> +       x=3D"-68.488571"
> +       y=3D"250.37801"
> +       id=3D"text159"><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-68.488571"
> +         y=3D"250.37801"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan159">CP is capable of</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-68.488571"
> +         y=3D"260.07941"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan160">following the</tspan><tspan
> +         sodipodi:role=3D"line"
> +         x=3D"-68.488571"
> +         y=3D"269.78079"
> +         style=3D"font-style:normal;font-variant:normal;font-weight:bold=
;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-f=
ont-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fi=
ll:#1c241c;stroke-width:0.400612"
> +         id=3D"tspan161">IB address.</tspan></text>
> +    <path
> +       style=3D"fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 38.977794,178.16115 V 132.60272 H 177.31847 V 80.437513"
> +       id=3D"path161"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 76.233608,174.60301 V 132.60272 H 177.31847 V 80.733511"
> +       id=3D"path162"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"m 185.48942,174.60301 v -42.00029 h -8.17095 V 81.325508"
> +       id=3D"path163"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 353.76849,176.69603 V 132.60272 H 177.31847 V 82.657499"
> +       id=3D"path164"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#55ddff;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 178.37314,176.69603 V 138.67068 H 307.08591 V 81.769505"
> +       id=3D"path165"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#55ddff;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"M 84.837713,176.69603 V 138.67068 H 307.08591 V 81.769505"
> +       id=3D"path166"
> +       sodipodi:nodetypes=3D"cccc" />
> +    <path
> +       style=3D"fill:none;stroke:#55ddff;stroke-width:1;stroke-linecap:s=
quare;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker1=
54)"
> +       d=3D"m 346.50011,180.10001 v -41.42933 h -39.4142 V 81.769505"
> +       id=3D"path167"
> +       sodipodi:nodetypes=3D"cccc" />
> +  </g>
> +</svg>
> --
> 2.47.2
>
