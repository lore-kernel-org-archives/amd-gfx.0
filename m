Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3D7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 17:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D6910E1A3;
	Thu, 13 Jan 2022 17:55:02 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E1E10E1A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 17:55:01 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 s8-20020a0568301e0800b00590a1c8cc08so7135597otr.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 09:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AyfzdositwQA49h6dpExArLuIGen3fmqMk+UP3ecDWY=;
 b=iSiekV48bszR9AMcunQYFdGaLgyThLWNP0Ssc0kqrMNzKOZSXEWulqrcnpkIOYqyj+
 q3NrYGl+UhHkvyJI5IFenqvguWTkIoGAlrNVTAQaKMpO++PinvM4Ec4d8KqzEGJlsPsY
 EfSPyH4t3DnQv0acLKdm237XsBoHpIRY0l4YxN4vseWjDlHSpqpTlH/cMs8a97mO/vd0
 s6in4fW8eXwNa8sXGUom6+j2CYDpSB3uKz9Aej63uNqekcwgVHdRCCE5ojG9lUEAaBhe
 haV4mwRZI2X0zT/nHSeG3Z7Q24EEqU8c3yYrYT4oZ81xByKCvBNXN4JRtfbt4IC5BD9c
 5Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AyfzdositwQA49h6dpExArLuIGen3fmqMk+UP3ecDWY=;
 b=vs5cLzmYumql3mfoGQ8QAypWy2JRUb0W8RIzZKDR+tbVbb05RiBsWrL7uRAkIshviA
 36Mez+xxKUx4soJqMWUaQfDewwKV0RBi0srYWxD4qxVGzoY4BD2PDL4SymP7L0QTvug+
 RAH3aXLqWFBFGy9TN/QmWh+TY8eldJomzbzadH+1FjXzbY9h8f7w3U+83CUDZ7XhT7/r
 uC71QOa8DSFNLtxcFX9As6jmyFeMtEtUGLinFUIduJ5/OIPM6I4h4nP/k2RBXtppLpif
 vsmp57IuPW1xFjd2344TeDcG1LIXbWCnxZ6hZZktN5oXDDMmwUqOA+lykgOCul/eItdF
 nuTg==
X-Gm-Message-State: AOAM533fXhkhZm+HcD5GsW8CEvlWNl+q9S6A6X1towVtTMQw/7RdRTP1
 jp4XQRcGyPvU0Utx3y8GgT8cTcYA7P7SUz4RePg=
X-Google-Smtp-Source: ABdhPJz1CYEuqS9xBR2K15HmGMuPYqtU7WykTABtIepY0groIKhyOv1v1r1mIWWv7w7jw0lokAT4aJYGjv2u1SbWxmk=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3994100otk.200.1642096501159; 
 Thu, 13 Jan 2022 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
 <20220112074802.2867813-2-YiPeng.Chai@amd.com>
 <DM5PR12MB177086BF0F422DFE80C636A7B0529@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB177086BF0F422DFE80C636A7B0529@DM5PR12MB1770.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jan 2022 12:54:50 -0500
Message-ID: <CADnq5_Nqqn1-G0E=1HpMcNe-a=b0cPNL-_WzA8dvD9n56LK2yQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list
 if it already exists in ras_list
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Clements,
 John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 12, 2022 at 3:36 AM Zhou1, Tao <Tao.Zhou1@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, January 12, 2022 3:48 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> > John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list if it
> > already exists in ras_list
> >
> > No longer insert ras blocks into ras_list if it already exists in ras_list.
> >
> > Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 62be0b4909b3..e6d3bb4b56e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2754,9 +2754,17 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> > *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> >               struct amdgpu_ras_block_object* ras_block_obj)  {
> > +     struct amdgpu_ras_block_object *obj, *tmp;
> >       if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
> >               return -EINVAL;
> >
> > +     /* If the ras object had been in ras_list, doesn't add it to ras_list again */
> [Tao] How about "If the ras object is in ras_list, don't add it again"
>
> > +     list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> > +             if (obj == ras_block_obj) {
> > +                     return 0;
> > +             }
> > +     }
>
> [Tao] The patch is OK for me currently, but I think the root cause is we initialize adev->gmc.xgmi.ras in gmc_ras_late_init, the initialization should be called only in modprobe stage and we can create a general gmc_early_init for it.

Yes, please fix the root cause.  We should only be adding the blocks
once.  This is just papering over the actual problem.

Alex


>
> > +
> >       INIT_LIST_HEAD(&ras_block_obj->node);
> >       list_add_tail(&ras_block_obj->node, &adev->ras_list);
> >
> > --
> > 2.25.1
