Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1938EC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 03:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87831113F30;
	Thu, 14 Jul 2022 03:43:50 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED8B7113F30
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:43:48 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id va17so1216437ejb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rfwCMFlRkLi/7ESur0nIKmfmriU2Vrw8/SZMJNo2gug=;
 b=JExzxKWmy+Y3Er62THvkM9pC9jUj4H5QaDFDNBKjdhEYVcz2lVfGTkSr9wUhq72aJS
 rto/3U/kEHxWHs27jXeEzwJnH7NX6YX4tUgsS073Sh3Oe1ucxHv9vNca7JytRUTfgsbx
 NMgeOXxjm/DkxDNTMdnPa4Uim7GBH3S4coTSPQZijTRYaiUzT687Qu3yWw7o8E6PwcQA
 pFXN4HJ+7aL5tSCkQFGUqX0fZ9uow5+d886ZruyHSe1j7QDN4V59/NE1XOMQb/1PlIUF
 AyJ+UZzCbcFyNWRbNOAwnUT0JlFkiprJOeQQNURdNnnQqRjBsJvw3nkufErpCZsL/z7a
 hGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rfwCMFlRkLi/7ESur0nIKmfmriU2Vrw8/SZMJNo2gug=;
 b=Ch0zef/Dhis0wHyHfSouSNLKG8hBPlgVUXkTp0d66BDr+7rul2fxbR4aKxUQh/qxLG
 RilqMvgtSHMnBRI5Cro3eftHfkU0TmlucgG0F5dMZ/jRrBywEtov2bgk77fXKdoyoubq
 65rmALSW9Sx+Cjd2VFAsKD14QBUVJaqpLys2atqQ0XaSo1UQ7MhtYOf0xajmhN9hmUOu
 pSMRYDi/iN/oQXR2dn3jQEyjSOCrGtPv5l7ZZnjrKYMrQ3fnh3e4QO+A8kixlujQreWc
 ueH1SjhlluZg5Xr0UxNfZVIjn/t1Zo4x8/ltbcgsU4aZEQoSeD5Vdaogl6ojqdFF2wiu
 4XBg==
X-Gm-Message-State: AJIora+3X6571xuK9yniqfhUj3i6WtBvhfJ3PUwnfLnBZzORAKdKeSKQ
 KmDLIEAk2dusFcHRFBvELfZaI1rvQ0d1h2F89o0=
X-Google-Smtp-Source: AGRyM1tqOqmw0p0g5E41wcFDhSyBAxA/p1cV8NDe52nhh6e6FZb22ly9Zl1eFY3xyMSaAXOoEY0qn4qTQHHk9giruWQ=
X-Received: by 2002:a17:906:5d0b:b0:726:a043:fcb4 with SMTP id
 g11-20020a1709065d0b00b00726a043fcb4mr6529795ejt.508.1657770227392; Wed, 13
 Jul 2022 20:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220713031704.2004-1-guchun.chen@amd.com>
 <CADnq5_PzunYt9CBWF5Z4s2EERe2WBDmpREnfDD48KYNPkeS95g@mail.gmail.com>
 <BL0PR12MB2465F64BAEAED76DD32EE204F1889@BL0PR12MB2465.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2465F64BAEAED76DD32EE204F1889@BL0PR12MB2465.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Jul 2022 23:43:35 -0400
Message-ID: <CADnq5_P-o2Ut_V5JM=w4XMHDtDYvyU7Ub8dwbHJcTNQW+ko9=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
To: "Chen, Guchun" <Guchun.Chen@amd.com>
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 11:15 PM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> Re: I think this would be better as:
> if (adev->in_runpm && (adev->pm.rpm_mode != AMDGPU_RUNPM_BOCO)) or something like that.
>
> Yes, patch 2 in this series addresses it. Patch 1 intends to fix SMU reloading, while patch 2 focus on fixing race issue when getting feature mask during runtime cycle.

I get that, but I think it would be better to switch the order of the
patches and then use the rpm_mode in this patch as well.  That way we
are consistent and we don't miss some case if we change the BACO or
BOCO logic in the future.

Alex

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, July 13, 2022 11:31 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case (v2)
>
> On Tue, Jul 12, 2022 at 11:18 PM Guchun Chen <guchun.chen@amd.com> wrote:
> >
> > SMU is always alive, so it's fine to skip SMU FW reloading when runpm
> > resumed from BACO, this can avoid some race issues when resuming SMU
> > FW.
> >
> > v2: Exclude boco case if an ASIC supports both boco and baco
> >
> > Suggested-by: Evan Quan <evan.quan@amd.com>
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index e9411c28d88b..de59dc051340 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -2348,6 +2348,14 @@ static int psp_load_smu_fw(struct psp_context *psp)
> >                         &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
> >         struct amdgpu_ras *ras = psp->ras_context.ras;
> >
> > +       /* Skip SMU FW reloading in case of using BACO for runpm only,
> > +        * as SMU is always alive.
> > +        */
> > +       if (adev->in_runpm &&
> > +           !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
> > +           amdgpu_device_supports_baco(adev_to_drm(adev)))
>
> I think this would be better as:
> if (adev->in_runpm && (adev->pm.rpm_mode != AMDGPU_RUNPM_BOCO)) or something like that.
>
> Alex
>
> > +               return 0;
> > +
> >         if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
> >                 return 0;
> >
> > --
> > 2.17.1
> >
