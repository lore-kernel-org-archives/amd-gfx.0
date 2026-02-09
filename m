Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25224E81BCF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 14:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB7610E3FF;
	Mon,  9 Feb 2026 14:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QrzYP4tX";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF4410E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 14:45:51 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12714f01940so95412c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Feb 2026 06:45:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770648350; cv=none;
 d=google.com; s=arc-20240605;
 b=iCs7OIfulILXjoJlBR8L7tLb6jtxLTAFStFmEIGS67n/64ozN149jl+tFqfx6+LMrO
 1SrdmR7Fz91VhFCBqMaaEKfFULpi2qXjtff39ZH9unV65Xjgh+rgeWX/HyNwgRVwvjV6
 ajsnWTW2dY4I78Fy7mw+pvCPrhuSF3mUc0LIW6a41elL7X12Yvu1UuQrT5PgMSzV6/ds
 Vfv4jXrQ0Und/rD6lOMhPaEqXWXyGASR155J73yhgb0soJWjxLcUluMeS18VkGzDEpFQ
 Lu/iN4wXPku/Ehs7kDXPIF4eXwQwxPLV+WsZb/g6O4JhoqqqM4a9FyuCydq9tTBAXMvp
 HC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yxpdwlb20vJO92qsdJJ5sGFoF9SO2qvmkdYcwm19rcg=;
 fh=XQ540fT+/lm58LMuqgTf7zm7IiZcwymjNXDHCytiuRg=;
 b=RR98P2dHh8squBG8d9v6H2pTjZ3N33l09WkqJsH1HROa8ukkz/35WMWGM1hp3/uhmR
 e36KTj1r3Qyot9grEQMG5yOOSCs2YqZ/esp9NzSSMnEwPPzTbNuvWb+57H6nLDc97y6R
 YUZpg90nd4AO/JBlEODy4YjTMXbNLZ0esO99S/PWhQaL0Nw8yjpRn2ODx910Gz3pcLVz
 EFFb0mykS//UC6Zd/8vJGSNJoHa5ylMYvRBOybsqpVC0VALMfdqkcYc6r+KKRMEpFEdq
 Xv/220cshM3D0E5Soh8jFmFm2j/lX1nIR5hnE7YjClamgKo8tHEPlj51GMgGKmQGGUl2
 kkZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770648350; x=1771253150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxpdwlb20vJO92qsdJJ5sGFoF9SO2qvmkdYcwm19rcg=;
 b=QrzYP4tX+6c+z0qqRFrITIxvLQKuDNHD1IrgWGkTNGG4ZwZMym3e5NqdN6wm82CLIr
 xunkZDYcqGOp80huivD6npbgaAIQI057KOpoIOjj1st432z0+XntV1hNerRkAuRsvR8z
 A43Q4xZaF3p9DGj1kfHKvRy5rH7v/DJVzkp9EbyxDxkfGHBO3srUaZurOq8nB5H+LIE1
 mr1qv3LeH1TTndwSxo1tvoHDRc6Or5KYPn5JC/lJonVAokz/I+9nNvEu+RNpihYq55AR
 vu6tf/yTVgDKg5A6ENeQ5qT8DKykQXhiVP4UN//XyK1Cza64QxfmfVwfNWnUgb+Uvzob
 UaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770648350; x=1771253150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yxpdwlb20vJO92qsdJJ5sGFoF9SO2qvmkdYcwm19rcg=;
 b=pqGLeK+6bmJGcmd9aT+Jjj7ljAUG2tbx3Zyz7aCRCkH8iUE6g3Uugdw8RvGAIi4IbZ
 Scx0VX/iF8N9zWqwLaOLpmRKHbQWAlK5XwEFMqd3OcpbMO7HbOXDt8MVahiSlifmbw9h
 q3VbgvKOOeK6JBCbciiq/ZTvBCwdVXaizJkcKtuRRO5JHWuukm/x7W2RYvciuzqNQQu2
 G+cNQ3BdAYuzizB2WyUU8xpaY4AvDVhi8jOa/7WWHASkeNBWxsStVbHg5R6fSsDuqeYl
 cmBTP8ydmRH38MZBM/sHF9pAqtQ45g9tMgrqGAR495lQSrRhy4o2OqbinfK3MW9R10qR
 xQNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCwDK6mVe2MPR7Ba48PB3+2Xy044PNMB4x2oKaYYm5X9Wgu1UbcnsYeOG+Vsb3n/yfe+x9xN7N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVZoZbPu3Eqz7IsuvUG2GUsDl/w0+WKnquZ7DvK6qjLzyYnceh
 PXs5xWJ7VM3HdoCEmpL6VBCTvuQwCwNSCNt8hXWm3AzX5VB7w8fnGNc9d1xW3LAJQn1z0ujaT3v
 D45OYm3M6bP3Cu75S9kVRdMVpZoWYfq4=
X-Gm-Gg: AZuq6aJLTSZCX3jUTXVaXSIp78i92Nbh0si5TdoSMDDhDauZtU+QtC70ySRd2OPYZuP
 GBgAv4w4otWF9SaPh0GqQdT2b/i9qSQqT3/5JawBfbWMYal2rRGSaAEl5ovp5B8muDuUqwfmJza
 QGOubOhGo5GoqZJWwPmtNd3ZIEtEajzbJvAJHUNNqAIMwCkNK0yrZyxojH3Lys/rmZC35lt9jTF
 k0ZMlikqmZ+q4tc78tK/marACJ+fP0H7XjcUCasAfX395FvFL2Eh5AN7BoYaQOnACRARrAp
X-Received: by 2002:a05:7022:6997:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-12703fd7080mr2897502c88.6.1770648350161; Mon, 09 Feb 2026
 06:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-7-perry.yuan@amd.com>
 <CADnq5_M59RNnzco4mSL90mfxKp++Z82ZyLBt17LtUKVkdxNEbQ@mail.gmail.com>
 <CYYPR12MB8655C9D60BD760C1CC1124F49C64A@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB8655C9D60BD760C1CC1124F49C64A@CYYPR12MB8655.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Feb 2026 09:45:38 -0500
X-Gm-Features: AZwV_Qi_Ht09U65afNtMvCRCvN1DDaPFdV0pk44OCRdbnCSUAAwC2OsoF1A_xbM
Message-ID: <CADnq5_N13XKCROmoLON3-hGGGMv93pVfQQycnrNrPHcp4PPgMQ@mail.gmail.com>
Subject: Re: [PATCH 07/22] Documentation/amdgpu: Add documentation for Peak
 Tops Limiter (PTL) sysfs interface
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
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

On Sat, Feb 7, 2026 at 10:17=E2=80=AFPM Yuan, Perry <Perry.Yuan@amd.com> wr=
ote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>  Hi Alex,
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, February 6, 2026 5:37 AM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org; Zhang, Yifan <Yifan1.Zhang@amd.com>
> > Subject: Re: [PATCH 07/22] Documentation/amdgpu: Add documentation for =
Peak
> > Tops Limiter (PTL) sysfs interface
> >
> > On Thu, Feb 5, 2026 at 11:57=E2=80=AFAM Perry Yuan <perry.yuan@amd.com>=
 wrote:
> > >
> > > The PTL (Peak Tops Limiter) feature exposes per-GPU sysfs files under
> > > /sys/class/drm/cardX/device/ptl/ to allow users to enable or disable
> > > PTL, configure preferred data formats, and query supported formats.
> > > The usage of these sysfs files is not always obvious, so add
> > > documentation to describe their purpose and provide concrete usage ex=
amples.
> > >
> > > V3 changes:
> > >  * format show will display preferred formats instead of N/A (Alex)
> > >
> > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > > Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> > > ---
> > >  Documentation/gpu/amdgpu/index.rst |  1 +
> > >  Documentation/gpu/amdgpu/ptl.rst   | 94
> > ++++++++++++++++++++++++++++++
> > >  2 files changed, 95 insertions(+)
> > >  create mode 100644 Documentation/gpu/amdgpu/ptl.rst
> > >
> > > diff --git a/Documentation/gpu/amdgpu/index.rst
> > > b/Documentation/gpu/amdgpu/index.rst
> > > index 8732084186a4..b2ab182236ef 100644
> > > --- a/Documentation/gpu/amdgpu/index.rst
> > > +++ b/Documentation/gpu/amdgpu/index.rst
> > > @@ -23,3 +23,4 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA
> > (CDNA) architectures.
> > >     debugfs
> > >     process-isolation
> > >     amdgpu-glossary
> > > +   ptl
> > > diff --git a/Documentation/gpu/amdgpu/ptl.rst
> > > b/Documentation/gpu/amdgpu/ptl.rst
> > > new file mode 100644
> > > index 000000000000..c7f16dea7954
> > > --- /dev/null
> > > +++ b/Documentation/gpu/amdgpu/ptl.rst
> > > @@ -0,0 +1,94 @@
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Peak Tops Limiter (PTL) sysfs Interface
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Overview
> > > +--------
> > > +The Peak Tops Limiter (PTL) sysfs interface enables users to control
> > > +and configure the PTL feature for each GPU individually.  All
> > > +PTL-related sysfs files are located under
> > > +`/sys/class/drm/cardX/device/ptl/`, where `X` is the GPU index.
> > > +Through these files, users can enable or disable PTL, set preferred =
data
> > formats, and query supported formats for each GPU.
> > > +
> > > +PTL sysfs files
> > > +----------------
> > > +The following files are available under `/sys/class/drm/cardX/device=
/ptl/`:
> > > +
> > > +- `ptl_enable`
> > > +- `ptl_format`
> > > +- `ptl_supported_formats`
> > > +
> > > +PTL Enable/Disable
> > > +------------------
> > > +File: `ptl_enable`
> > > +Type: Read/Write (rw)
> > > +
> > > +Read: Returns the current PTL status as a string: `enabled` if PTL i=
s
> > > +active, or `disabled` if inactive.
> > > +
> > > +Write:
> > > +
> > > +- Write `1` or `enabled` to enable PTL
> > > +- Write `0` or `disabled` to disable PTL
> >
> > Ideally `enable` or `disable`, I.e., drop the "d".
> >
> > Alex
>
> Could we retain the current 'enabled' and 'disabled' states?  While they =
may not be ideal, changing them would break compatibility with the amd-smi =
tool that already has been released to user.

Ok.

Alex

>
>
> Thanks.
> Perry.
>
> >
> > > +
> > > +Examples::
> > > +
> > > +    # Query PTL status
> > > +    cat /sys/class/drm/card1/device/ptl/ptl_enable
> > > +    # Output: enabled
> > > +
> > > +    # Enable PTL
> > > +    sudo bash -c "echo 1 > /sys/class/drm/card1/device/ptl/ptl_enabl=
e"
> > > +
> > > +    # Disable PTL
> > > +    sudo bash -c "echo 0 > /sys/class/drm/card1/device/ptl/ptl_enabl=
e"
> > > +
> > > +PTL Format (Preferred Data Formats)
> > > +-----------------------------------
> > > +File: `ptl_format`
> > > +Type: Read/Write (rw)
> > > +
> > > +Read: Returns the two preferred formats, e.g. `I8,F32`.
> > > +
> > > +Write: Accepts two formats separated by a comma, e.g. `I8,F32`.
> > > +
> > > +- Both formats must be supported and different.
> > > +- If an invalid format is provided (not supported, or both formats
> > > +are the
> > > +  same), the driver will return "write error: Invalid argument".
> > > +
> > > +Examples::
> > > +
> > > +    # Query PTL formats
> > > +    cat /sys/class/drm/card1/device/ptl/ptl_format
> > > +    # Output: I8,F32
> > > +
> > > +    # Set PTL formats
> > > +    sudo bash -c "echo I8,F32 > /sys/class/drm/card1/device/ptl/ptl_=
format"
> > > +
> > > +Supported Formats
> > > +-----------------
> > > +File: `ptl_supported_formats`
> > > +Type: Read-only (r)
> > > +
> > > +Read: Returns a comma-separated list of supported formats, e.g.
> > > +`I8,F16,BF16,F32,F64`.
> > > +
> > > +Example::
> > > +
> > > +    # Check supported formats
> > > +    cat /sys/class/drm/card1/device/ptl/ptl_supported_formats
> > > +    # Output: I8,F16,BF16,F32,F64
> > > +
> > > +Behavioral Notes
> > > +----------------
> > > +- PTL formats can only be set when PTL is enabled.
> > > +- If PTL is disabled, `ptl_format` returns `N/A`.
> > > +- Only two formats can be set at a time, and they must be from the s=
upported set
> > and different..
> > > +- All commands support per-GPU targeting.
> > > +- Root permission is required to enable/disable PTL or change format=
s.
> > > +- If the hardware does not support PTL, the PTL sysfs directory will
> > > +not
> > > +  be created.
> > > +
> > > +Implementation
> > > +--------------
> > > +The PTL sysfs nodes are implemented in
> > `drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c`.
> > > --
> > > 2.34.1
> > >
