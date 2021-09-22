Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 20:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C8C610D1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 20:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16C8C610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F2F89688;
	Wed, 22 Sep 2021 20:25:41 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168F389688
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 20:25:39 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 l16-20020a9d6a90000000b0053b71f7dc83so5298632otq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lbrDt0Ui6mRAty/yoHe7Ddt6LVMHpSFGeMci+eEkV74=;
 b=EWDWo3vrzfcekRyYHLCLAa0eNcdLTpSuhSjkRrwohcWLiMI63ENaP9T21aBYHJrbTZ
 4vtPjUIFzKOWlgs0OKh8j0FxAYak1FaJYdOVpC9d+wnmEuxvMFSfRXRFFeqKM0+vRjLv
 6wCBKtGxt/QaSImj8aQqM0qa9xDms070ceV9zR9E667TEmXHcwkyq2j2AJeZNELFZ8AQ
 +3fN9PYHMY0AdwH7ZJLEHuba0szp4TcQIHesKDdSwobFRf0AUudO7XszMPhB5C157j2n
 3EWMD7GVJ3hVP7OEYUmAsIscYb7bm3BubTVOPSWzjotO3KEdDPF6RPF7i4rgFtfGALUe
 ti4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lbrDt0Ui6mRAty/yoHe7Ddt6LVMHpSFGeMci+eEkV74=;
 b=Rvpvb7Ds+bSG8h4RjiXunjx4tqq80rYfeHDFh+YNbfoT+qX1UJyNNSMhaul5aEKhHO
 JI12318i29y30D+NKhG7/yBiGRNU4mRGJ3mhg9d6o2XV8zM+SmhepDt/JpprnbLumuoV
 b0/TNE6lJDStrIuyk0YApX65UHohqux+mcKcXYuJTzqLTYMKnFrAontASIHzLfPj39lA
 aqusraCJNnMydMVDxfdNKTC5e1VwtklIQy5J8Qzq6tGXpSjE+t9eKb/sY4pbFYpY7jTx
 L2oEpM6qcLO94bFnK/I0+b05Fa5759/pwj12V7nORpHCBZIVFj4UUFSI33eKAbuB9zU3
 ODGw==
X-Gm-Message-State: AOAM531RdMIMqkat3U1XseEncQE9R71Bzo+KsmVPFbEbFJeD+zgzXfj9
 ayZDH29Li9AkFnSUPTTyF6yPTJkUhzpxRQJAqZ8=
X-Google-Smtp-Source: ABdhPJxcFhiJo671QzPl2dORpgZKcAmZeaZJu3vGnL51lRCF21VkkBVMa/0SAioKW0JnLFL7VJ7KMMwcckAGnf1Co4E=
X-Received: by 2002:a05:6830:2704:: with SMTP id
 j4mr921286otu.299.1632342338342; 
 Wed, 22 Sep 2021 13:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <54e06b10-1921-5791-75a8-38a0041ef569@gmail.com>
In-Reply-To: <54e06b10-1921-5791-75a8-38a0041ef569@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Sep 2021 16:25:27 -0400
Message-ID: <CADnq5_PT8G9gUurtn5OZzi8JhAPUaWaRPf0Xmzb+8Nib5FQJtg@mail.gmail.com>
Subject: Re: [PATCH 00/66] Move to IP driven device enumeration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Sep 22, 2021 at 3:54 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> OMFG what mother of all patch sets.
>
> Patches #1-#6, #12, #14-#15, #27, #31, #35-#36, #59-#60, #64, #66 are
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Patches #7-#11, #13, #16-#26, #29-#30, #33-#34, #37-#50, #53, #55-#56,
> #58, #62, #65 are Acked-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>
>
> Comment for patch #28:
>
> Doesn't this one needs to come before #27?

I've swapped them, but the order doesn't matter in this case as we
still set the asic_type for all existing chips so it will work either
way.

>
> Comment for patch #32:
>
> Maybe adjust the commit subject, otherwise somebody could think it's a
> revert the the previous patch.

I was thinking I could just apply 31 independently of what happens to
this patch set.  I meant to split it out as a separate bug fix patch,
but it got lost in the other patches.

>
> Comment on patch #51, #52 and #61:
>
> That looks just a little bit questionable. Could we clean that up or
> would that be to much churn for little gain?

What did you have in mind?  As I mentioned in the reply to Lijo, the
IP discovery table uses a mix of separate HWIDs and multiple instances
of the same HWID to handle instancing.

>
> Comment on patch #54:
>
> Looks like this is only adding SDMA instances and not VCN as said in the
> subject.

Fixed.

>
> Comment on patch #57:
>
> Where is the removing of the harvest register access?

fixed.

>
> Comment on patch #63:
>
> >               case IP_VERSION(7, 2, 0):
> > -                     amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_blo=
ck);
> > +                     if (!(adev->asic_type =3D=3D CHIP_VEGA20 && amdgp=
u_sriov_vf(adev)))
> > +                             amdgpu_device_ip_block_add(adev, &uvd_v7_=
0_ip_block);
>
> Checking the IP version and then the chip type looks questionable. I
> have an idea where this comes from, but please confirm with a comment.

It's just because SR-IOV is only enabled on certain asics and that is
the way the old code looked.  I guess I could drop the asic_type
checks.  We'd never end up in with amdgpu_sriov_vf() returning true on
a asic without SR-IOV support in the first place.

Alex

>
> Regards,
> Christian.
>
> Am 21.09.21 um 20:06 schrieb Alex Deucher:
> > This patch set moves the driver to an IP driven discovery model
> > rather than one tied to PCI device ids.  This allows the
> > GPU driver to claim all ATI PCI display class devices.  The
> > driver will then either load or not based on the IPs (GC, SDMA,
> > DCN, VCN, etc.) that are enumerated on the device.  All recent
> > asics contain an IP discovery table which enumerates the
> > number and version of all IPs on the board. This avoids the need
> > to add new DIDs for new parts even if the driver would already
> > otherwise support the new chip (i.e., support for all of the IPs
> > are in place). It also better handles asics which have different
> > numbers of instances of IPs.  We can just use the IP discovery
> > table rather than maintaining hardcoded information in the
> > driver.  Finally, we can avoid adding lots of asic type checks
> > all over the driver to add a new asic if the IP version is
> > already supported.
> >
> > Alex Deucher (64):
> >    drm/amdgpu: move headless sku check into harvest function
> >    drm/amdgpu: add debugfs access to the IP discovery table
> >    drm/amdgpu: store HW IP versions in the driver structure
> >    drm/amdgpu: fill in IP versions from IP discovery table
> >    drm/amdgpu: add XGMI HWIP
> >    drm/amdgpu/nv: export common IP functions
> >    drm/amdgpu: add initial IP enumeration via IP discovery table
> >    drm/amdgpu/sdma5.0: convert to IP version checking
> >    drm/amdgpu/sdma5.2: convert to IP version checking
> >    drm/amdgpu/gfx10: convert to IP version checking
> >    drm/amdgpu: filter out radeon PCI device IDs
> >    drm/amdgpu: bind to any 0x1002 PCI diplay class device
> >    drm/amdgpu/gmc10.0: convert to IP version checking
> >    drm/amdgpu: Use IP discovery to drive setting IP blocks by default
> >    drm/amdgpu: drive nav10 from the IP discovery table
> >    drm/amdgpu/gfxhub2.1: convert to IP version checking
> >    drm/amdgpu/mmhub2.0: convert to IP version checking
> >    drm/amdgpu/mmhub2.1: convert to IP version checking
> >    drm/amdgpu/vcn3.0: convert to IP version checking
> >    drm/amdgpu/athub2.0: convert to IP version checking
> >    drm/amdgpu/athub2.1: convert to IP version checking
> >    drm/amdgpu/navi10_ih: convert to IP version checking
> >    drm/amdgpu/amdgpu_smu: convert to IP version checking
> >    drm/amdgpu/smu11.0: convert to IP version checking
> >    drm/amdgpu/navi10_ppt: convert to IP version checking
> >    drm/amdgpu/sienna_cichlid_ppt: convert to IP version checking
> >    drm/amdgpu: drive all navi asics from the IP discovery table
> >    drm/amdgpu/nv: convert to IP version checking
> >    drm/amdgpu/display/dm: convert to IP version checking
> >    drm/amdgpu: add DCI HWIP
> >    drm/amdgpu: make soc15_common_ip_funcs static
> >    drm/amdgpu/soc15: export common IP functions
> >    drm/amdgpu: add initial IP discovery support for vega based parts
> >    drm/amdgpu/soc15: get rev_id in soc15_common_early_init
> >    drm/amdgpu: drive all vega asics from the IP discovery table
> >    drm/amdgpu: default to true in amdgpu_device_asic_has_dc_support
> >    drm/amdgpu/display/dm: convert RAVEN to IP version checking
> >    drm/amdgpu/sdma4.0: convert to IP version checking
> >    drm/amdgpu/hdp4.0: convert to IP version checking
> >    drm/amdgpu/gfx9.0: convert to IP version checking
> >    drm/amdgpu/amdgpu_psp: convert to IP version checking
> >    drm/amdgpu/psp_v11.0: convert to IP version checking
> >    drm/amdgpu/psp_v13.0: convert to IP version checking
> >    drm/amdgpu/pm/smu_v11.0: update IP version checking
> >    drm/amdgpu/pm/smu_v13.0: convert IP version checking
> >    drm/amdgpu/pm/amdgpu_smu: convert more IP version checking
> >    drm/amdgpu/amdgpu_vcn: convert to IP version checking
> >    drm/amdgpu/vcn2.5: convert to IP version checking
> >    drm/amdgpu/soc15: convert to IP version checking
> >    drm/amdgpu: add VCN1 hardware IP
> >    drm/amdgpu: store all instances of IPs in the IP version table
> >    drm/amdgpu: get VCN and SDMA instances from IP discovery table
> >    drm/amdgpu/sdma: remove manual instance setting
> >    drm/amdgpu/vcn: remove manual instance setting
> >    drm/amdgpu: get VCN harvest information from IP discovery table
> >    drm/amdgpu/ucode: add default behavior
> >    drm/amdgpu: add new asic_type for IP discovery
> >    drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default
> >    drm/amdgpu: convert IP version array to include instances
> >    drm/amdgpu: clean up set IP function
> >    drm/amdgpu: add support for SRIOV in IP discovery path
> >    drm/amdkfd: clean up parameters in kgd2kfd_probe
> >    drm/amdkfd: convert kfd_device.c to use GC IP version
> >    drm/amdgpu: add an option to override IP discovery table from a file
> >
> > Guchun Chen (2):
> >    drm/amd/display: fix error case handling
> >    drm/amdgpu: add HWID of SDMA instance 2 and 3
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   3 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   5 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  44 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 818 +++++++++++++++++=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 578 ++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 101 ++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   7 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  47 +-
> >   drivers/gpu/drm/amd/amdgpu/athub_v2_0.c       |   7 +-
> >   drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |   9 +-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 380 ++++----
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 227 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |   6 +-
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  91 +-
> >   drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c         |  15 +-
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |  73 +-
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |   6 +-
> >   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  13 +-
> >   drivers/gpu/drm/amd/amdgpu/nv.c               |  91 +-
> >   drivers/gpu/drm/amd/amdgpu/nv.h               |   2 +
> >   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  44 +-
> >   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  14 +-
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 100 +--
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  32 +-
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  51 +-
> >   drivers/gpu/drm/amd/amdgpu/soc15.c            | 167 ++--
> >   drivers/gpu/drm/amd/amdgpu/soc15.h            |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   1 -
> >   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   1 -
> >   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   6 +-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  12 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 259 ++++--
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 216 ++---
> >   drivers/gpu/drm/amd/include/soc15_hw_ip.h     |   2 +
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  89 +-
> >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  50 +-
> >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  24 +-
> >   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  96 +-
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  22 +-
> >   include/drm/amd_asic_type.h                   |   1 +
> >   43 files changed, 2595 insertions(+), 1131 deletions(-)
> >
>
