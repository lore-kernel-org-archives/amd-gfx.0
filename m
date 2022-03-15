Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413E7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 15:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2BD10E536;
	Tue, 15 Mar 2022 15:53:40 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B32B10E536
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 15:53:39 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id w2so13200056oie.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YrGSq5r3SU2NFxwiko4Dpz9bnbGLGj8RiSMDQ7WVepI=;
 b=XmvZlIyMeBE9Kxy6yu7y9xw9W8AmzIvojkNDeM0Q3W0VudLA9ZNcj943FzwIUMGE4q
 gJM4Cqt8FlHfLcayi7v1ImyGNnhaeGKHjluBiy5XMsd5ASjSp8fdqxBrn3JHrOr8VQ5Z
 8HiLqrJmzhuj8i9pV0/prwQlHEXAW6F4AX5YB60wEJTo4N8Lsx8qhNLpsZZVNyvdDQiV
 wxrfoOrvMsizAFEX8P+KJ/XUGgH1OxtWwZD6B/+PzmPk47Rsv+koAsw58Euz5QrYxptC
 +8Lx40tTtyWuVLw8vOUWkjnpuAub2qGX8Rk8zzIymtXv1yYPpwe0OwMuVScy9j9HcuMs
 g+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YrGSq5r3SU2NFxwiko4Dpz9bnbGLGj8RiSMDQ7WVepI=;
 b=AwWJ+m/J6KtD9kp1CBi+8IhQsy/XK0bEwlblhA/o5yAXcJy84UInEef50G7jWhQqfH
 WVH2etnu4F2rjOdY2CeiVMgYB3sGHRQKm6v0DdIfqQgxd/awnNmFrnkJthANk8Wq8Jcc
 mn30ITNrdhlKMdZgDEK7Z59A4slCvrtQSLWOXeuwmzIAgCPAcn0DQ2eG+PSxgq4GJkag
 bKgXAeRFR0ND9jduQW1OWGf/4+aSMcwbvv1EdywqNIvNQaWpxD0CbCPjBp/W7zfMCjw5
 LV4BJEbI3YDTpFHQeKRg48wK2yLRbfdkSSbiX1NscA2DeloGjyMS81b1+mBJQFPJQBa6
 5nZA==
X-Gm-Message-State: AOAM531iIa3i2QSUMfrm1uh5D7X6CjkOjalHZZfjXo9l0tnnWPPJG2Jp
 8yWRD8EgdeJIQP7dlr/O8bfh+s5fLGWKjMwQvkk=
X-Google-Smtp-Source: ABdhPJwpNEMd8Sklhy609OdpAxNPdBO1TJB5y9av0cI3UMkcn4vn9GGyMJNvIxAbE/mhUNZtxB7cRHOyvSCakwDq7bA=
X-Received: by 2002:aca:d07:0:b0:2ec:eaaf:a036 with SMTP id
 7-20020aca0d07000000b002eceaafa036mr2049512oin.253.1647359618702; Tue, 15 Mar
 2022 08:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220314140405.GC30883@kili>
 <e54bbfa5-bcbf-8b84-8c94-c181c774c64c@amd.com>
In-Reply-To: <e54bbfa5-bcbf-8b84-8c94-c181c774c64c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Mar 2022 11:53:27 -0400
Message-ID: <CADnq5_PZdO4DuzYCVCt=TtES7WeRHe5fas8WugrrpeBK2YZB8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix indenting in __smu_cmn_reg_print_error()
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, David Airlie <airlied@linux.ie>,
 Lijo Lazar <lijo.lazar@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Prike Liang <Prike.Liang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Graham Sider <Graham.Sider@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Darren Powell <darren.powell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Mar 14, 2022 at 12:06 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Thanks!
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
> On 2022-03-14 10:04, Dan Carpenter wrote:
> > Smatch complains that the dev_err_ratelimited() is indented one tab more
> > than the surrounding lines.
> >
> >       drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:174
> >       __smu_cmn_reg_print_error() warn: inconsistent indenting
> >
> > It looks like it's not a bug, just that the indenting needs to be cleaned
> > up.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index ae64d1980f10..b8d0c70ff668 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -164,17 +164,17 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
> >
> >       switch (reg_c2pmsg_90) {
> >       case SMU_RESP_NONE: {
> > -     if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> > -             msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
> > -             prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> > -     } else {
> > -             msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> > -             prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> > -     }
> > +             if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
> > +                     msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
> > +                     prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
> > +             } else {
> > +                     msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
> > +                     prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> > +             }
> >               dev_err_ratelimited(adev->dev,
> >                                   "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
> >                                   msg_idx, prm);
> > -     }
> > +             }
> >               break;
> >       case SMU_RESP_OK:
> >               /* The SMU executed the command. It completed with a
>
> Regards,
> --
> Luben
