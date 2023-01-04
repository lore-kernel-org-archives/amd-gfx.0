Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864FC46467
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D4910E0BA;
	Wed,  4 Jan 2023 14:16:07 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9910E0BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:16:06 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1441d7d40c6so39979925fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEmOllgX9D4ROlutRtUAKfbqa0B/g2Jb5DRjrYVYMOI=;
 b=UUQDYWmiF52jgstl4eo9WlaMvP7l4+Oqy9bMUW4hej5m5gQIMCzTY+dWZDCOuX9ogJ
 BxCLuK474BWhyWb/FLzHt4ujiCvxCjyL8nE0/A4e5G6DmSqn5lnYq4uHeVz3BYAIit5Z
 diVzHHqq9MsJBj1OGx3R1E7MygGCGxZJDrTf1RAldIj0AHBFuUwpRypJ8de/DFpHku+V
 pulsCy3dgr0hMxug/wN7I23oQyc1z+wX/UoCiA04jPYcYmiwST7hZ7MxGTKdnvTvqjP4
 5f2QOawxdo6fN2eyD7kSOBLwFmQlcDdWYMCASDtWS2Ws2kM2Zv0BVp1zc+SNsQ87JrCf
 vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rEmOllgX9D4ROlutRtUAKfbqa0B/g2Jb5DRjrYVYMOI=;
 b=2FGwl2d6kkmZgov3qeSc/MdrjIl9hHlavlDWhKXO8goP6iBlmOScOZLfZ7oR6fzWXB
 6q/XhatUb0NPIV0DoeesmF64+TPIwfnX8+MgNyoNhQO+eYxrQqUOMK33Vjd0A2TbV5WF
 IllfzGwMHWtyUsWXoMQA13JvNqaWQP6iQcYM6uCiFMzBSe7iEkDzLCQrgwZJbFjqLyCQ
 1ZaBvEuTyhYcmUXbrFgbq39W1v4htbjTEoA6iLmKnGCO/OC5DqHb/s4TCB3qEUtyLFTb
 SzmkFi5yaSzR0VxTbt7mpcbz010YRg/nliPAowM8QU3GZdumJtuCkAVrSXxjG7nyfzFz
 lo+g==
X-Gm-Message-State: AFqh2krmWVKn1Zi+SKz0BTUcjMdeQ0+SyaJ8YgCK/M2pF0ubk+sE371r
 zCj7FyBTNETn0z3qozpnj+frPDU/A0gLgGJLH7Ns7GeT
X-Google-Smtp-Source: AMrXdXvscJDYVzPeG3CaREBz+TWXai7GKkyTAGfYCnA7grsf0RfzB6A+WKckZgPsZemmMUl6zVcZ5zPG20BWgQ3lass=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr3948655oaq.46.1672841765948; Wed, 04
 Jan 2023 06:16:05 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
In-Reply-To: <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jan 2023 09:15:54 -0500
Message-ID: <CADnq5_P=7MkeFMW-nacm5UpTQpDXE2LjDD1tDtmvd+DnQ_+x4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > I see. Well, those sysfs files are not usable, and I don't think it
> > would be important even if they were usable, but for completeness:
> >
> > The ioctl returns:
> >      pcie_gen =3D 1
> >      pcie_num_lanes =3D 16
> >
> > Theoretical bandwidth from those values: 4.0 GB/s
> > My DMA test shows this write bandwidth: 3.5 GB/s
> > It matches the expectation.
> >
> > Let's see the devices (there is only 1 GPU Navi21 in the system):
> > $ lspci |egrep '(PCI|VGA).*Navi'
> > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> > Upstream Port of PCI Express Switch (rev c3)
> > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> > Downstream Port of PCI Express Switch
> > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
> >
> > Let's read sysfs:
> >
> > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
> > 16
> > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
> > 16
> > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
> > 16
> > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
> > 2.5 GT/s PCIe
> > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
> > 16.0 GT/s PCIe
> > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
> > 16.0 GT/s PCIe
> >
> > Problem 1: None of the speed numbers match 4 GB/s.
>
> US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Total
> theoretical bandwidth is then derived based on encoding and total number
> of lanes.
>
> > Problem 2: Userspace doesn't know the bus index of the bridges, and it'=
s
> > not clear which bridge should be used.
>
> In general, modern ones have this arch=3D US->DS->EP. US is the one
> connected to physical link.

navi and newer have a US and DS bridge, while vega only have a single
bridge.    Pre-vega are just exposed as endpoints.  The EP to bridge
links are always the max supported lanes/gen because they are virtual
links.  The US is the actual physical link to the system.  Also note
that the PMFW will change the gen speed on the fly dynamically based
on traffic so just reading it at idle will always show the slowest
speed.

Alex

>
> > Problem 3: The PCIe gen number is missing.
>
> Current link speed is based on whether it's Gen1/2/3/4/5.
>
> BTW, your patch makes use of capabilities flags which gives the maximum
> supported speed/width by the device. It may not necessarily reflect the
> current speed/width negotiated. I guess in NV, this info is already
> obtained from PMFW and made available through metrics table.
>
> Thanks,
> Lijo
>
> >
> > That's all irrelevant because all information should be queryable via
> > the INFO ioctl. It doesn't matter what sysfs contains because UMDs
> > shouldn't have to open and parse extra files just to read a couple of
> > integers.
> >
> > Marek
> >
> >
> > On Tue, Jan 3, 2023 at 3:31 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com
> > <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> >
> >     Sure they can, those files are accessible to everyone.
> >
> >     The massive advantage is that this is standard for all PCIe devices=
,
> >     so it should work vendor independent.
> >
> >     Christian.
> >
> >     Am 02.01.23 um 18:55 schrieb Marek Ol=C5=A1=C3=A1k:
> >>     Userspace drivers can't access sysfs.
> >>
> >>     Marek
> >>
> >>     On Mon, Jan 2, 2023, 10:54 Christian K=C3=B6nig
> >>     <ckoenig.leichtzumerken@gmail.com
> >>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> >>
> >>         That stuff is already available as current_link_speed and
> >>         current_link_width in sysfs.
> >>
> >>         I'm a bit reluctant duplicating this information in the IOCTL
> >>         interface.
> >>
> >>         Christian.
> >>
> >>         Am 30.12.22 um 23:07 schrieb Marek Ol=C5=A1=C3=A1k:
> >>>         For computing PCIe bandwidth in userspace and troubleshooting
> >>>         PCIe
> >>>         bandwidth issues.
> >>>
> >>>         For example, my Navi21 has been limited to PCIe gen 1 and thi=
s is
> >>>         the first time I noticed it after 2 years.
> >>>
> >>>         Note that this intentionally fills a hole and padding
> >>>         in drm_amdgpu_info_device.
> >>>
> >>>         Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com
> >>>         <mailto:marek.olsak@amd.com>>
> >>>
> >>>         The patch is attached.
> >>>
> >>>         Marek
> >>>
> >>
> >
