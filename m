Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CC1C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 18:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5AB10E0C8;
	Mon, 27 Nov 2023 18:11:23 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2BF10E0C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 18:11:21 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1fa2b8f7f27so1223695fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 10:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701108681; x=1701713481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZpnOthRbLnBBpEEWYgeGNsasjoY9FPd9WygBxdXcBw=;
 b=UdS7EAjrxS+dj769JaSBvLXjsc82k5uphmEG0lRAyPeg/txdtfpC3DhOeZ0lCiv8FI
 3w6eraTQ/d001Jr0c6WC1Od7R26qzBgwLAGDSFt4t7sncihvzHZhTQOgZ2lNm+RXU6mg
 jrlBTvtDns4Vg+l4PeIUFgg/Cl+9gN11Urh/pV5H8xaJGovcKVJ4q+erDVqDVw5gFD6k
 1hEqZqv6/zuB8XjxRlfSxPouXeGHYpEGxA1DAlA+1nzIG7v50zbc5ZUD1xq7zar1FPc9
 DFO5tkadvtMEbuT79awxSwoTJnRKOuoOqZMpotk+3pQADpxNnr3EU257K1RWGonI20HU
 lj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701108681; x=1701713481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZpnOthRbLnBBpEEWYgeGNsasjoY9FPd9WygBxdXcBw=;
 b=TMJxt3GQhw4dHD6Jhr5v6JUAej+tTprPCPY36X2vqc8K8S+WzdiQpch/mJtf2/UIYi
 HARGN7RwOWxfV385zQh8E3FX0QU0iBQkr4Izm3lYyvVqyKSV0bQBfQ7/D4p9Qc/FNBLK
 jbQ+a32ucT8PKyocoPzM2hP6CNSFnTe8b+ji5dF4xR+iDYcTb0lT8JvW8tQX2zUxurYd
 QxbcqHY3yQj9DtrehxnJHqZDNUeutANXkw6XlzBpOZlYR7gYFCnOd4qSLlXvE8NZL22y
 nSwuWmFrH+bx+C1H5YpjrD3jPyGOQAEFaM4Bn/5MF5UJbctR6+5NGiiJ8MQZg3jTcDSg
 ITGQ==
X-Gm-Message-State: AOJu0YzGle/ycfWVkMDFKR24kt6sGsyMNbjuUt7W+M7dKynDw62AViE4
 Nd5FsSPi4Ax6tuiktdQPyBkGB0ZvkZ3q8/v3PH+24jtK
X-Google-Smtp-Source: AGHT+IEZ2Q1pPFFtrc4DZMkZZf1dFGfQfy1FQra1QFO0P3NVZ5tug31nYbbhrMJlHAIRN8Cg98fI5rZIWVMyELuwYFY=
X-Received: by 2002:a05:6870:8092:b0:1f9:6247:4d05 with SMTP id
 q18-20020a056870809200b001f962474d05mr15112722oab.22.1701108681026; Mon, 27
 Nov 2023 10:11:21 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 13:11:09 -0500
Message-ID: <CADnq5_P8aRkj340FtBJKsZDnV8iOCmdmCHDWKHGca+4UtfNy1A@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: "Lee, Alvin" <Alvin.Lee2@amd.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 15, 2023 at 1:52=E2=80=AFPM Lee, Alvin <Alvin.Lee2@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
> This change has a DMCUB dependency - are you able to update your DMCUB ve=
rsion as well?
>
> This version mismatch issue is something I'll need to fix in driver for L=
inux.

@Mahfooz, Hamza @Alvin Lee any update on a fix for this?

Thanks,

Alex

>
> Thanks,
>
> Alvin
>
> -----Original Message-----
> From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Sent: Wednesday, November 15, 2023 1:22 PM
> To: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> Cc: Lee, Alvin <Alvin.Lee2@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Wh=
eeler, Daniel <Daniel.Wheeler@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Linux List Kernel Mailing <linux-kernel@vger.kernel.org>; amd-=
gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horiz=
ontal flashing bar with a picture of the desktop background on white screen
>
> On Wed, Nov 15, 2023 at 11:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd=
.com> wrote:
> >
> > What version of DMUB firmware are you on?
> > The easiest way to find out would be using the following:
> >
> > # dmesg | grep DMUB
> >
>
> Sapphire AMD Radeon RX 7900 XTX PULSE OC:
> =E2=9D=AF dmesg | grep DMUB
> [   14.341362] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
> [   14.725547] [drm] DMUB hardware initialized: version=3D0x07002100
>
> Reference GIGABYTE Radeon RX 7900 XTX 24G:
> =E2=9D=AF dmesg | grep DMUB
> [   11.405115] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
> [   11.773395] [drm] DMUB hardware initialized: version=3D0x07002100
>
>
> --
> Best Regards,
> Mike Gavrilov.
