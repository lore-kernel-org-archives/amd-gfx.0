Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E10DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 16:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EB110E618;
	Fri, 16 Dec 2022 16:51:52 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A882310E05A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 16:51:43 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1433ef3b61fso3929104fac.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 08:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ywc8VIgmXCTBIE199+rk5mzq5qaeSl+WUhlmVngJJ1A=;
 b=L+pfjkYQhfOZ8Dor1vEHE2L2t3ggc27j6iO2wwIB/MZBUO87EQgAHs4Og0YDKdEr6V
 r2KwVuyQ/6KdyP90757zc4UzgqQHlAvi8gFsZluoW2xbxq06rlaqCstmoj9tDRI3950i
 VkK6LNHOi51A7LMW7CEP8zLo3JG4TTCs8cg3yD35QNi4l+GHS9EkPJ6/9DQaepkFx9KJ
 yqAXpb+kOU/i1LmN7AZpLtBN0G+NIvZkJESvYUv49otn1D4H6W7vE4/bg17eGKn2r/gN
 iBuywOWlTMJn65ge3sKzGXhVhi2J/AE9lGXKSG2hWUE/NsJy2JwJ8L/MDqoQBAXJztNG
 k2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywc8VIgmXCTBIE199+rk5mzq5qaeSl+WUhlmVngJJ1A=;
 b=A/XPE/n0upZ07+Wqc9RotQ/PJcwLlHbBO6eno4eaZojhdQ9yluQdMKAUYade93+kXb
 kHwyuSqoUuRlZ1OVdoCo2UwQycYt3UPTm8hQWoHSOnPrYnODwzTQV2OMQZq9k2pWLRRh
 2QwfhUYpsRXQfRbYKflrbtWlJszOCdlWVfMtUtgu/hPR0e5B9FnzB193gXkP6Dz1QUAU
 HAggNDEDKkJOYIiODzYDVkbHlNh3h85juelwBCBxOS1FF9inKYTxg3vcmi0BLIlBaUsA
 iosxE6jxGKV2bVkrGysv6b8wqMTrLUwQGvf4t/QQPAxLcl0bjG8FUFU7KJHE+qVAuG3B
 OLyw==
X-Gm-Message-State: AFqh2kpc38rUs1mgydKfMMg/VUiO8dRY21BqPotG/uGEtitGwK8zFErF
 MeHcsaoJAcoOhJerp/EBhL5rjUfMAx8wTFV4xi9gNeyR
X-Google-Smtp-Source: AMrXdXskZiBty3jjR15JJ5gACocuhYIh8SD+VNLr/yyTzW+Pl13oRo175j3wXDpWYq9RTadAOCB/N/+5Gn8cMz6N3Vg=
X-Received: by 2002:a05:6870:4687:b0:143:8a81:116c with SMTP id
 a7-20020a056870468700b001438a81116cmr1121166oap.96.1671209502787; Fri, 16 Dec
 2022 08:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20221215221059.509565-6-alexander.deucher@amd.com>
 <5379267a-6035-85bd-23cc-d0c22893e6c1@amd.com>
In-Reply-To: <5379267a-6035-85bd-23cc-d0c22893e6c1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Dec 2022 11:51:31 -0500
Message-ID: <CADnq5_NMNhzYxDju7OEtxgtEiXSpbEkrzCzE+PqVxjWfsGLkAg@mail.gmail.com>
Subject: Re: [5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
To: "Limonciello, Mario" <mario.limonciello@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 16, 2022 at 9:35 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> +Tim
>
> On 12/15/2022 16:10, Alex Deucher wrote:
> > SDMA 5.x is part of the GFX block so it's controlled via
> > GFXOFF.  Skip suspend as it should be handled the same
> > as GFX.
> >
> > v2: drop SDMA 4.x.  That requires special handling.
> >
> > Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index a99b327d5f09..5c0719c03c37 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
> >                    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
> >                       continue;
> >
> > +             /* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
> > +             if (adev->in_s0ix &&
> > +                 (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0)) &&
> > +                 (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
> > +                     continue;
> > +
>
> I think we want to also skip MES here too, right?  That might be a
> follow up patch though.

Sent as a follow up.

Alex

>
> >               /* XXX handle errors */
> >               r = adev->ip_blocks[i].version->funcs->suspend(adev);
> >               /* XXX handle errors */
>
