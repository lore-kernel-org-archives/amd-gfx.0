Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 16:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CF373CD6;
	Wed,  8 Dec 2021 16:30:48 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F91B73CD6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 16:30:47 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 x19-20020a9d7053000000b0055c8b39420bso3294818otj.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LI+6NyTFbiaG5wx1Z2+Q7KxQDLUg3qTNFd+xP2Ikx8A=;
 b=C5AOqucdSYK1tRNNcuAmMXl1urqXdGvum9SeSfT6H5+RR02E0HNrH1eUYk0H9ga1+q
 5oG1JwgUhct4Bo2U5fz69qgHDjt/XTJksm91S6QvWZvt4d+71uAyMPfvNl8LV3I9hmV7
 aE8sVzDDpOXIBa3IWEqzh++CiCcGmTLgajSu8AUexXWnpz4VTC3HsmnFd/HsfSOfIvet
 UhrKW6fRg557t3WkUoQwP2tRvIrffSzp5prV7Lmc6uAiOuZ36Plz/mqLlAN9Qxq6MbzB
 hfuzGADkW/72cD2QhZFStfmaIq5wQgsyXATIszqApXbSoDNrOALh3SUBuChA24OXCCVd
 nkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LI+6NyTFbiaG5wx1Z2+Q7KxQDLUg3qTNFd+xP2Ikx8A=;
 b=rwzcPcsU7jhh3ylcTvKNSOWHbkgsmHkuCsvl2KBmC3EQmxebLkX5DjX6QDtHtWmPTb
 ObuCnQLksP7FAYc/HM7H6BpLO00/Pm0jtn732Et8MysXnkbAyMX6enujDXK8DwUWB0Xj
 l9+j+doVEm+FmcPRDIy5LtepnGOKH4N+kzD+lLXLDRdX5YEQQzJQ9yDR2CXpSE42vCU5
 vJF3c+MXPIJ+9orwa8QXdZh6HNixSdoycWykrMMHcdJpj0U2Nfzfn+4h4+10B7ZVHiTg
 tYkZEGXWxZGZVjClseaR0Zrsodke18y9GZnAcdFD1RynONt+fA/kUufbMpCF4cX2iEvs
 4nhQ==
X-Gm-Message-State: AOAM5303muvS86o+xJdOyQH8VOiqWcM5yCNLluuP9Y0Iq4oTuFLmtCiK
 U6GAsoiCRTXXypWgFygY7UHPoeOuPwEvw+tYzM4=
X-Google-Smtp-Source: ABdhPJyEG0xtdmPKvfCkz5TMh1/cUP6xaDPFuMYsu7smqMzoLGmXFNHRCkiYr+zqgpkTrTJ9ht+OLhqroqe6B8439wE=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr461895oto.357.1638981046429; 
 Wed, 08 Dec 2021 08:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20211208084615.437375-1-Yuliang.Shi@amd.com>
 <DM5PR12MB246969CECC6AC8D12C2856A3F16F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <6879fff2-fd58-677d-7473-682f1413c5d3@amd.com>
In-Reply-To: <6879fff2-fd58-677d-7473-682f1413c5d3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 11:30:35 -0500
Message-ID: <CADnq5_OQ-LNK=Agbabcuyr9_xgBWjtNR-zUC0inkhCEQGQ+OvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Shi, Leslie" <Yuliang.Shi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 8, 2021 at 11:09 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 12/8/2021 2:43 PM, Chen, Guchun wrote:
> > [Public]
> >
> > Hi Leslie,
> >
> > Can we move revision handling in this patch into amdgpu_discovery_get_vcn_version? Then we will maintain all revision handlings only in amdgpu_discovery.c.
> >
>
> This seems to be more about VCN config than revision. A better thing to
> do will be to rename sriov_config as vcn_config and use that here
> (regardless of SRIOV or not).
>
> Change discovery code to -
>         adev->vcn.vcn_config[adev->vcn.num_vcn_inst] = (ip->revision & 0xc0);
>
> And check here as:
>         vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK
>
> Looks like baremetal enables all and VF enables only encode or decode on
> particular VCN instance.
>

That seems cleaner.  We can also drop
amdgpu_discovery_get_vcn_version() and just use vcn_config.

Alex

> Thanks,
> Lijo
>
> > Regards,
> > Guchun
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leslie Shi
> > Sent: Wednesday, December 8, 2021 4:46 PM
> > To: amd-gfx@lists.freedesktop.org
> > Subject: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
> >
> > Guest OS will setup VCN instance 1 which is disabled as an enabled instance.
> > This will cause VCN ib ring test failure during modprobe.
> >
> > Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
> > Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > index 2658414c503d..2323815ac32d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -293,6 +293,9 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
> >       if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
> >               return true;
> >
> > +     if (amdgpu_sriov_vf(adev))
> > +             revision |= adev->vcn.sriov_config[vcn_instance] << 6;
> > +
> >       if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> >               ret = true;
> >       } else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> >
