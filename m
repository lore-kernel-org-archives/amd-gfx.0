Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF33C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2135B10E034;
	Mon, 14 Apr 2025 19:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mtgIjGT+";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA9C10E034
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:04:28 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso871325a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744657467; x=1745262267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2u+wDvl+bbjDYogL1LhobDpHq7k5Wqw5fdr2N/uK3So=;
 b=mtgIjGT+JBZ0KhICL/ontEmC5uB19CNub8IUJFBSqsEgFcddITIDNkO1jCIwZ9BILl
 pntEcoLO2vyOdT9WOwKx3HCprJKFq0FgFr9XOHJUj2sYgBKo20XkwMjfkkrzODVswYS6
 7tAu/q2PzA507oNkFYJYC4gIpiaDc357bvxtvg9ApgLFRtu23cMYY5uk+xcIcA/fxk2I
 /Kq5YGCItw4i5fs9VSs9FcaTKrF2bp5gTU+DbErArfUMsXLn15vVR7YWhVg0SkuFs3Tf
 wxVqwAxHLP/j2UC8VW5kKLBgwffLdy+aoPlejaJv6h/K8NY1Mikd35gK5SND5dYy0LDH
 dIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744657467; x=1745262267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2u+wDvl+bbjDYogL1LhobDpHq7k5Wqw5fdr2N/uK3So=;
 b=Ss+6NoevGS4IP8cLZHxu+hXOq6kBRzKSU+X9jGPGA5cmDhBt4Sfh765OCoKfLpv79g
 6dDu/Tqi2Ti0+/TwTsr+eUUksdJ138KMm2B8RVPHMRiVwZQInslT4BS0rdgfYmKyesdn
 cDL7mEnR3hf2jj1vKbxu0HRPR1Gg6my/1BgPX8cKUNjxyfdgfoyKn9WiBenpDAz6S1Td
 jC1pOlRBddBIA9lXIhu6fpF8jTm23+NYF1sEirR6gUbrvZkLDeGDMa6Ld7Bs7osTL2t0
 prZp7vP85zwyMFJeMDfSsnIy0OTpK+Zob8+4JT6LdTx+aNvRfjFrzKzxqd+CwhHFP7i1
 Y9Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNXSETKB3sNEWxrFopC8XMAd1oh3El37+IOzmvTSdhE6YZjc/b3A5h6z1piDLLmtLnSrQSBUdY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4AAGNmD7z1Ky54xe3zC1++xNrzfvRR55OzZoJsmxAJVSqXep6
 iQWtT2tXOl0gcJiAP2R2+rY+cLZezGUCFGjxo3mLYwWSfDDBjC6hve+osdwq0aIPq9OZSL72rjm
 KD3rMcHSElujDFmezfO5xUKgEm+4=
X-Gm-Gg: ASbGncuA5s4LRojLnfuLuVZS2cGtI75mAF8AFol2NlJ9uEdK20hf63Ixe/a0wAJhELz
 hMM9vYAO51JJ7TH2an0c4ir5xR3MBIzfJ/kXkt2+JhXbEyslKzdkOlrTox/43EOcEcSJKPJOC1g
 1xcMc92lwmQY9UKcVypwGzfA==
X-Google-Smtp-Source: AGHT+IFvC0Xfik7XeGkXjV/UGf5XyO3Aw6htc2DOoyfGlisjVxKog+HZcg9kDnaWM5mO9f2WjecpbwHKMb+JiLz6CuA=
X-Received: by 2002:a17:90b:384b:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-3084e75753emr508865a91.3.1744657467365; Mon, 14 Apr 2025
 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250414171259.2996574-1-alexander.deucher@amd.com>
 <20250414171259.2996574-4-alexander.deucher@amd.com>
 <b9d71139-f431-4c2a-b1c5-18e2d52cc004@amd.com>
In-Reply-To: <b9d71139-f431-4c2a-b1c5-18e2d52cc004@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 15:04:15 -0400
X-Gm-Features: ATxdqUEBO73RvF9icr38-Y4XQpnOiYjPj4PnEltq331MJTfdEHQg6V2jcieVUwU
Message-ID: <CADnq5_MxnffvndJ9BsmAHVUknpxfOyYw+ASABdTWrM-W2E2Xdg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/userq: integrate with enforce isolation
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Apr 14, 2025 at 1:58=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
> If i am not wrong @arvind  is already having the patch to remove this
> config. Should we use the function pointer check as being used in EOP
> and SDMA functions ?

The list will be empty if there are no user queues active.  Although,
thinking about it more, we only need to stop gfx and compute queues
for enforce isolation.  I will rework the patches.

Alex

>
> Regards
> Sunil Khatri
>
> On 4/14/2025 10:42 PM, Alex Deucher wrote:
> > Enforce isolation serializes access to the GFX IP.  User
> > queues are isolated in the MES scheduler, but we still
> > need to serialize between kernel queues and user queues.
> > For enforce isolation, group KGD user queues with KFD user
> > queues.
> >
> > v2: split out variable renaming, add config guards
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index c58d32983c45e..71c8b30b1659c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1970,6 +1970,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu=
_device *adev, u32 idx,
> >               if (adev->gfx.userq_sch_req_count[idx] =3D=3D 0) {
> >                       cancel_delayed_work_sync(&adev->gfx.enforce_isola=
tion[idx].work);
> >                       if (!adev->gfx.userq_sch_inactive[idx]) {
> > +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> > +                             amdgpu_userq_stop_sched(adev, idx);
> > +#endif
> >                               if (adev->kfd.init_complete)
> >                                       amdgpu_amdkfd_stop_sched(adev, id=
x);
> >                               adev->gfx.userq_sch_inactive[idx] =3D tru=
e;
> > @@ -2027,6 +2030,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct =
work_struct *work)
> >               /* Tell KFD to resume the runqueue */
> >               WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
> >               WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> > +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> > +             amdgpu_userq_start_sched(adev, idx);
> > +#endif
> >               if (adev->kfd.init_complete)
> >                       amdgpu_amdkfd_start_sched(adev, idx);
> >               adev->gfx.userq_sch_inactive[idx] =3D false;
