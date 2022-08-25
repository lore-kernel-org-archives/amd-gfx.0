Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5161EC6498F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 15:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7566C10E727;
	Thu, 25 Aug 2022 15:25:57 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBE410E71D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 15:25:55 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id v125so23715319oie.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=yxeSBwCRpC3IkR5beajdjeCxWi5mcjj85A5eeY+o+UM=;
 b=Y3K25gM5QxbXIu0ZaKbwvmKinWyrhLeNSDIjh4LQdOnnJk6nnTGpCZMKqM3SVfgAVO
 6EupUrEqDBt8xkWowffDRM4Vld/clewmsyWpCUs/G8nJNI+uFRER7DnAEdyFxyU5bIbA
 De9x1XhGOXla6MpGjbStgLoNYcTn31tZvbjrTHQXdl2dTTXa9bzD/9i2hX6ekK0q1aXu
 Q6sQmFKJl1r4r8lJBK4gnCYgpKs2KnNuK8SQsVVDjODz893UJRXVu/8mm3C+13Juutlc
 2Jf/aulJabe8fHAY5dF6w+fvRYqbwWaUZjOXqGxEwMTEPHihHAaiiew+BYAKqCbg4CfC
 mdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=yxeSBwCRpC3IkR5beajdjeCxWi5mcjj85A5eeY+o+UM=;
 b=UQKkoCfIzz5eZv6ItxH5M3IsepYeD8Em26J9Hi1fNy6gJrbjSrOdZB24fdWeLrp7rw
 4HKzGwkPx2Mscjd9l4dTevnPy3cBAmoJ4at89RXfNf2ihxDlxYmKkFiEhEvERtRDeO43
 +mjIZ4/habO6cpYR9MhpoX8SuQit5JA/XTT9G7Q/A2okAhjZRY4AyVo8gxfona+eGihx
 rS8ujJ3Uq9s5b9jScnM4GsmY796iV6oVQ2pA1czD3YNSQUgj5C+2jEGiB0+TV0Lqufx/
 yP1CwCkQnIrBKgP+lIKQ9EDV3+TrjmUuHr70tKiw4H7PYRZruhbVW51nJE1INiy1DF2G
 U4MA==
X-Gm-Message-State: ACgBeo28u+xSwXaCuyPyJZijOgxasxj2eTSQngcJ8Z7ye1Gm3keclnzJ
 lWcaeiqOGQYhhRmaqffdxy9StLcz9gxFCFTz0tE=
X-Google-Smtp-Source: AA6agR4YEShh3zKCjf8bhQs3qMWX2/gIzdz1He5KPhBqyyO84KTUPQOW2UI7GYV0O1eVXuDBcsjKmdKqsn31kp288UI=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr5857701oib.46.1661441154684; Thu, 25
 Aug 2022 08:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220822155217.911506-1-mukul.joshi@amd.com>
 <CADnq5_OGYxgEVOahp9wAvoVmhHDazhZwERK2s+x-gc43114URg@mail.gmail.com>
 <BL3PR12MB64251CF377D41A059954E76BEE729@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB64251CF377D41A059954E76BEE729@BL3PR12MB6425.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Aug 2022 11:25:43 -0400
Message-ID: <CADnq5_P7p8fwwK5-AEeup6hB3TU8HPNsas28JL5RMJVv_qv4bg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 25, 2022 at 10:49 AM Joshi, Mukul <Mukul.Joshi@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, August 25, 2022 9:33 AM
> > To: Joshi, Mukul <Mukul.Joshi@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
> >
> > [CAUTION: External Email]
> >
> > On Mon, Aug 22, 2022 at 11:53 AM Mukul Joshi <mukul.joshi@amd.com>
> > wrote:
> > >
> > > When translate_further is enabled, page table depth needs to be
> > > updated. This was missing on Arcturus MMHUB init. This was causing
> > > address translations to fail for SDMA user-mode queues.
> > >
> >
> > Do other mmhub implementations need a similar fix?  It looks like some of
> > them are missing similar changes.
> >
>
> I am not sure if there is a plan to enable translate_further on other ASICs.
> For now, its only enabled for Arcturus, Aldebaran and Raven.
> If we plan to enable it on other ASICs, then yes the other mmhub implementations
> would need similar changes.

It would be nice to fix them up preemptively so that if we ever enable
it on another asic, it will just work.

Alex


>
> Regards,
> Mukul
>
> > Alex
> >
> > > Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend
> > UTCL2 reach"
> > > Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > > b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > > index 6e0145b2b408..445cb06b9d26 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > > @@ -295,9 +295,17 @@ static void
> > > mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
> > > static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device
> > *adev, int hubid)  {
> > >         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
> > > +       unsigned int num_level, block_size;
> > >         uint32_t tmp;
> > >         int i;
> > >
> > > +       num_level = adev->vm_manager.num_level;
> > > +       block_size = adev->vm_manager.block_size;
> > > +       if (adev->gmc.translate_further)
> > > +               num_level -= 1;
> > > +       else
> > > +               block_size -= 9;
> > > +
> > >         for (i = 0; i <= 14; i++) {
> > >                 tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
> > mmVML2VC0_VM_CONTEXT1_CNTL,
> > >                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET
> > > + i); @@ -305,7 +313,7 @@ static void
> > mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
> > >                                     ENABLE_CONTEXT, 1);
> > >                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> > >                                     PAGE_TABLE_DEPTH,
> > > -                                   adev->vm_manager.num_level);
> > > +                                   num_level);
> > >                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> > >                                     RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> > >                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL, @@
> > > -323,7 +331,7 @@ static void mmhub_v9_4_setup_vmid_config(struct
> > amdgpu_device *adev, int hubid)
> > >                                     EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
> > >                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> > >                                     PAGE_TABLE_BLOCK_SIZE,
> > > -                                   adev->vm_manager.block_size - 9);
> > > +                                   block_size);
> > >                 /* Send no-retry XNACK on fault to suppress VM fault storm. */
> > >                 tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> > >
> > > RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> > > --
> > > 2.35.1
> > >
