Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0561C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D1010E682;
	Thu, 28 Apr 2022 22:14:13 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDFC10E682
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:14:12 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so6512832fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=A9wT2G4zx+OlAIflfTuGmkC7Qh8zAduJOs4UhUembXs=;
 b=QgZp1GhBs8/wo2HEbpJWtHG+QUFiJBSoZnrM4lHFUpu/NKPgu2xxu/ySYQUrZFDJ2Q
 gm1F+xpWyZnvJmkY0LZSoBKRgyBH+HrGlYp2dvZSkbHuX8o5isnBlsy9EDO+771+7GoS
 Fwdm08EgFnrqyTA78I89oB+zOFXr0Jw1tk20CZJHbkz3loUUUlsn8eGIpo2JZ810EuvK
 6d7K64On8A39oWGktBqmKy5w/9D08Tx78VmXISDeEC1hwYZY3WQ25hgbrslCzz27JJve
 AxQJCZN4BWXzIyW/mXaYQfQiYW4FiKk+mDmPRWxIh52/cN7LxfAl/GRpBmUcH0NLuJPP
 /aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A9wT2G4zx+OlAIflfTuGmkC7Qh8zAduJOs4UhUembXs=;
 b=F/WlPBeNO+IIygHOVmTlt4ieD1DKm6AKYz0o4cxl/4JndnCopbfh3NEpX6lFfT3doG
 qJcfSu3YqET8oUNtJEmHM5wNdPhH6ZHpesVCN/w80VMi8nTokJXwPrkJZtz/crIiYhPh
 bL8f0OD36Oc2mBH5lEVVfypwdMtuqCL3ZSSFzVY+VmtQiw6j44oC6DZmxAg/g9py8QUW
 lPg1dgPoYGkUSxpo4q73S0VwKYe+duUEzWFDY4fgryFeTrA8qd8Ph2d9AHxolx6wa+ik
 s2Bnf3kL4Ln0pWPVm4XCyQRPHck+SQZGLReWO+KcWilpGiIGuYm3Xex9fDaiGaeZm1zI
 lvJg==
X-Gm-Message-State: AOAM532jtViPQ+dFJRO5rNZBngKLUltenPsqFU3J0YG1DtIwQh/5LPQ+
 I9YmqYltfISur33dYx08v6+EWlNjwqUqf/O66pE259bi
X-Google-Smtp-Source: ABdhPJw7GkzIEgtPSnGfFIdNSzyvVSuClAGdMZdGuQPavI3kr+pDvFDlKNZGK+qM3Kw9Td4yO0ddYhDVEb1qkdwJc0s=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr150844oap.253.1651184051844; Thu, 28 Apr
 2022 15:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220420214715.2644898-1-shiwei.wong@amd.com>
 <CADnq5_ORQYj6ro4u9P4j7+NHVCMmn-iJ_FNzcNsiVHCro0J8KQ@mail.gmail.com>
 <DM6PR12MB3963944F7765140E05D7AEA3EBF79@DM6PR12MB3963.namprd12.prod.outlook.com>
 <CADnq5_N7yckjOTwEDnVZCBrtcqj7YE+gnkfGWofy0-b=ah3CeA@mail.gmail.com>
 <CADnq5_PLOZ3xMcMnK5Rg8J_ev8LFP2vKsmP_EJ+J8rAAZ1j+Xw@mail.gmail.com>
 <DM6PR12MB39632AAEDAA3768273B3DD3DEBFD9@DM6PR12MB3963.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB39632AAEDAA3768273B3DD3DEBFD9@DM6PR12MB3963.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Apr 2022 18:13:59 -0400
Message-ID: <CADnq5_PMXs-iMJfR0a3YQKbpmP4UcHwJoyk32eqYpTD07DTJJw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
To: "Wong, Alice" <Shiwei.Wong@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good.  Thanks for fixing that.  I've sent the patches out for review!

Alex

On Wed, Apr 27, 2022 at 9:37 PM Wong, Alice <Shiwei.Wong@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Need this patch on top of your patches to handle psp_load_fw failure.
>
> Alice
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: April 22, 2022 5:23 PM
> To: Wong, Alice <Shiwei.Wong@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
>
> How about these patches?
>
> Alex
>
> On Fri, Apr 22, 2022 at 5:00 PM Alex Deucher <alexdeucher@gmail.com> wrot=
e:
> >
> > On Fri, Apr 22, 2022 at 3:54 PM Wong, Alice <Shiwei.Wong@amd.com> wrote=
:
> > >
> > > [AMD Official Use Only]
> > >
> > > Hi Alex,
> > >
> > > The attached patch freed most of the allocated memory except for one =
allocated by psp_tmr_init during psp_load_fw.
> > > Combination of the attached patch and calling psp_hw_fini when psp_hw=
_init failed would fix the issue.
> > >
> > > As a proper fix, we can call psp_tmr_terminate in psp_load_fw when
> > > psp_load_non_psp_fw failed. (attached patch) We can't move psp_tmr_in=
it to sw_init because we need to load toc to get the TMR size.
> > > Do you have any concerns with this approach?
> >
> > That only covers failures in hw_init().  It doesn't handle resume().
> > Looks like all of the ta functions also potentially leak.  I'm working
> > on a cleanup to handle all of these.
> >
> > Alex
> >
> > >
> > > Alice
> > >
> > >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: April 21, 2022 1:31 AM
> > > To: Wong, Alice <Shiwei.Wong@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > > Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed
> > > v2
> > >
> > > On Wed, Apr 20, 2022 at 5:48 PM Alice Wong <shiwei.wong@amd.com> wrot=
e:
> > > >
> > > > If at any point psp_hw_init failed, psp_hw_fini would not be
> > > > called during unload due to ip_blocks[PSP].status.hw not being set =
to true.
> > > > This could cause a memory leak when the driver unloads.
> > > > As a rule of thumb, each IP block should cleanup themselves when
> > > > their hw_init fails. Only previously intialized blocks should be
> > > > cleaned up by the common framework.
> > > >
> > > > v1: Call IP blocks' respective hw_fini when hw_init failed from
> > > >     the common framework
> > > > v2: Call psp_hw_fini when psp_hw_init failed.
> > > >
> > > > Signed-off-by: Alice Wong <shiwei.wong@amd.com>
> > >
> > > I don't think this is a good idea.  The hw programming in hw_fini mak=
es no sense if the driver never set it up in the first place if hw_init fai=
led before initializing the hw.  It would be better to just properly unwind=
 the relevant functions.  Presumably the problem you are seeing is the fail=
ure to free the GPU memory allocated in fw_fini, depending on where it fail=
s.  We should just allocate the memory in sw_init; that is what we do in ot=
her IPs.  Does the attached patch fix the issue you are seeing?
> > >
> > > Alex
> > >
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57
> > > > +++++++++++++------------
> > > >  1 file changed, 29 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > index 5b9e48d44f5b..52b14efa848a 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > > @@ -2537,6 +2537,34 @@ static int psp_load_fw(struct amdgpu_device =
*adev)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int psp_hw_fini(void *handle) {
> > > > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)hand=
le;
> > > > +       struct psp_context *psp =3D &adev->psp;
> > > > +
> > > > +       if (psp->ta_fw) {
> > > > +               psp_ras_terminate(psp);
> > > > +               psp_securedisplay_terminate(psp);
> > > > +               psp_rap_terminate(psp);
> > > > +               psp_dtm_terminate(psp);
> > > > +               psp_hdcp_terminate(psp);
> > > > +       }
> > > > +
> > > > +       psp_asd_terminate(psp);
> > > > +
> > > > +       psp_tmr_terminate(psp);
> > > > +       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> > > > +
> > > > +       amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> > > > +                             &psp->fw_pri_mc_addr, &psp->fw_pri_bu=
f);
> > > > +       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> > > > +                             &psp->fence_buf_mc_addr, &psp->fence_=
buf);
> > > > +       amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_ad=
dr,
> > > > +                             (void **)&psp->cmd_buf_mem);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static int psp_hw_init(void *handle)  {
> > > >         int ret;
> > > > @@ -2563,37 +2591,10 @@ static int psp_hw_init(void *handle)
> > > >  failed:
> > > >         adev->firmware.load_type =3D AMDGPU_FW_LOAD_DIRECT;
> > > >         mutex_unlock(&adev->firmware.mutex);
> > > > +       psp_hw_fini(handle);
> > > >         return -EINVAL;
> > > >  }
> > > >
> > > > -static int psp_hw_fini(void *handle) -{
> > > > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)hand=
le;
> > > > -       struct psp_context *psp =3D &adev->psp;
> > > > -
> > > > -       if (psp->ta_fw) {
> > > > -               psp_ras_terminate(psp);
> > > > -               psp_securedisplay_terminate(psp);
> > > > -               psp_rap_terminate(psp);
> > > > -               psp_dtm_terminate(psp);
> > > > -               psp_hdcp_terminate(psp);
> > > > -       }
> > > > -
> > > > -       psp_asd_terminate(psp);
> > > > -
> > > > -       psp_tmr_terminate(psp);
> > > > -       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> > > > -
> > > > -       amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> > > > -                             &psp->fw_pri_mc_addr, &psp->fw_pri_bu=
f);
> > > > -       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> > > > -                             &psp->fence_buf_mc_addr, &psp->fence_=
buf);
> > > > -       amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_ad=
dr,
> > > > -                             (void **)&psp->cmd_buf_mem);
> > > > -
> > > > -       return 0;
> > > > -}
> > > > -
> > > >  static int psp_suspend(void *handle)  {
> > > >         int ret;
> > > > --
> > > > 2.25.1
> > > >
