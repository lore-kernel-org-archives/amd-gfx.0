Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445B9C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 14:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAEA11BF2D;
	Mon, 18 Jul 2022 14:58:51 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EC511BE9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 14:58:50 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-10c0119dd16so24381876fac.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j9FiFPjl3O5gMjTZ2ttraEK6ZYwgnSzmIiWZOr07cJo=;
 b=hFgRxTiDFFSKur9PonsskJ0AQIp615dwLTLjiIbnLK8NHpzEhMjK5sd6/DcXElz9kQ
 U9XvUgnMqNsHCoS+jfKzheHOGpBi9AsyrenNIvosThG06NkWO40FweZF7WYfG5YmPi9e
 Apa7UL3pk7Ae/ciVbc6pIMLtrBar0Wqmed3DuW9KYZTIfO4/tjIUW1EVEmfKmOv+WkEl
 9yJXfc/Rl1C/F2zkFBKVUE8PjM6bxSmoQV3HrXV+z6gt8hNr3gmPrpuQrk4VVqNEzhzf
 obvSt9NsDqj+TaHMTLo2qQ6biNGcKbe7xKSFe7uSee12/VwYDZrTkEhx3kab8aUv1VOC
 PGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j9FiFPjl3O5gMjTZ2ttraEK6ZYwgnSzmIiWZOr07cJo=;
 b=5OMyZ0deqQ8tn59+KVztfsp0lRBclmHYFJt/dccTmYh8xpMM5tqtv52Ev25bTVe26N
 Oi5ak840g2z/Y2+qL9h7fsuBzMDl57/9w817ONV9eXgvPIUR0rhYtGOcxCQ159NwoHs/
 Fb/fxeEALxFhR0Q3RIhj6EZ2HPIK7CYtRbmOUNHJJHcqUkfTc3eDOTQNsnIELFmejf7Z
 gyztPZXeDZ06hvtonK9JYhSxUl1SGDfbDOrwwhJ3/WNhCfTwRb9svBUgNoP3To0fgItY
 DNxeaZTbXr0gPMwZy/TqtgfxI95zXUBMrt6aHf2n1bSPmGEGAj5TBTHRiHQXlbV8dlv9
 S6bg==
X-Gm-Message-State: AJIora/oxSxZxFPj0Q7BlXicDGUQOClwODkAkhzJXxu7f11HVklXnLrd
 SQYt5S4kZzUgUXsSFoL9Cq3TVlaQxua35FKYHRlhoQ==
X-Google-Smtp-Source: AGRyM1vXgAynzgDlIRQurBAS4lmEjyevCNuvexyjdP8iJl8goVCOojakuCQnEHJpsKHQrBt3KCJdmuA1rtWwuKJGpq4=
X-Received: by 2002:a05:6808:2094:b0:33a:16b7:ab30 with SMTP id
 s20-20020a056808209400b0033a16b7ab30mr12763231oiw.148.1658156329638; Mon, 18
 Jul 2022 07:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220707095053.6755-1-xinhui.pan@amd.com>
 <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
 <4b60ece6-afa5-62ca-afa6-bb800cdba982@amd.com>
 <DM4PR12MB5165724D36AB92CF9D40728487829@DM4PR12MB5165.namprd12.prod.outlook.com>
 <1766b5b0-05f1-b88e-3147-c5ac1749f0d1@gmail.com>
In-Reply-To: <1766b5b0-05f1-b88e-3147-c5ac1749f0d1@gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 18 Jul 2022 15:58:38 +0100
Message-ID: <CAHbf0-FKQjkhAsQh=CKTBz755ROrnJN0p05Yq=5mJ+L9xZow4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Is this likely to land before 5.19 final? It's been nearly 2 weeks
since I said if fixed an issue I was seeing
https://gitlab.freedesktop.org/drm/amd/-/issues/2074

On Fri, 8 Jul 2022 at 10:05, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi guys,
>
> well the practice to remove all fences by adding a NULL exclusive fence
> was pretty much illegal in the first place because this also removes
> kernel internal fences which can lead to freeing up memory which is
> still accessed.
>
> I've just didn't noticed that this was used by the KFD code as well
> otherwise I would have pushed to clean that up much earlier.
>
> Regards,
> Christian.
>
> Am 08.07.22 um 03:08 schrieb Pan, Xinhui:
> > [AMD Official Use Only - General]
> >
> > Felix,
> > Shared fences depend on exclusive fence, so add a new exclusive fence, =
say NULL would also remove all shared fences. That works before 5.18 . =F0=
=9F=98=89
> >  From 5.18, adding a new exclusive fence(the write usage fence) did not=
 remove any shared fences(the read usage fence). So that is broken.
> >
> > And I also try the debug_evictions parameter. No unexpected eviction sh=
ows anyway.
> > I did a quick check and found amdgpu implement BO release notify and it=
 will remove kfd ef on pt/pd BO. So we don=E2=80=99t need this duplicated e=
f removal. The interesting thing is that is done by patch f4a3c42b5c52("drm=
/amdgpu: Remove kfd eviction fence before release bo (v2)") which is from m=
e =F0=9F=98=89 I totally forgot it.
> >
> > So I would make a new patch to remove this duplicated ef removal.
> >
> > -----Original Message-----
> > From: Kuehling, Felix <Felix.Kuehling@amd.com>
> > Sent: Thursday, July 7, 2022 11:47 PM
> > To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhu=
i <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
> >
> > Am 2022-07-07 um 05:54 schrieb Christian K=C3=B6nig:
> >> Am 07.07.22 um 11:50 schrieb xinhui pan:
> >>> Fence is accessed by dma_resv_add_fence() now.
> >>> Use amdgpu_amdkfd_remove_eviction_fence instead.
> >>>
> >>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> index 0036c9e405af..1e25c400ce4f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> @@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct
> >>> amdgpu_device *adev,
> >>>          if (!process_info)
> >>>            return;
> >>> -
> >>>        /* Release eviction fence from PD */
> >>>        amdgpu_bo_reserve(pd, false);
> >>> -    amdgpu_bo_fence(pd, NULL, false);
> >>> +    amdgpu_amdkfd_remove_eviction_fence(pd,
> >>> +                    process_info->eviction_fence);
> >> Good catch as well, but Felix needs to take a look at this.
> > This is weird. We used amdgpu_bo_fence(pd, NULL, false) here, which wou=
ld have removed an exclusive fence. But as far as I can tell we added the f=
ence as a shared fence in init_kfd_vm and amdgpu_amdkfd_gpuvm_restore_proce=
ss_bos. So this probably never worked as intended.
> >
> > You could try if this is really needed. Just remove the eviction fence =
removal. Then enable eviction debugging with
> >
> >       echo Y > /sys/module/amdgpu/parameters/debug_evictions
> >
> > Run some simple tests and check the kernel log to see if process termin=
ation is causing any unexpected evictions.
> >
> > Regards,
> >     Felix
> >
> >
> >> Regards,
> >> Christian.
> >>
> >>>        amdgpu_bo_unreserve(pd);
> >>>          /* Update process info */
>
