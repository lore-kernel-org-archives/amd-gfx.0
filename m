Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C33C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E100E10E03C;
	Thu, 27 Jul 2023 18:27:11 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC0C10E03C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:27:09 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1bb782974f4so1048861fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690482429; x=1691087229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oM3ayirwjADgOzG0Vn2+S8SWr4cG70rvwnLoTrmx2qw=;
 b=PFs8mOSi31ESOWcHB3yhFjq/jL18f2lzORafb8uxrI2A/17I4uuKtHGqumfAZRJOHk
 3SFZpyyQryZlkVM7/P9msIkbFwqjVH9EACn0KgFhH3M2gaqDwqGkV3d8iY3iI+byrsWG
 3WAE/bNPmdwnIXbSR+ssNwHyP8v314nc1/Rw3AwhBmOrG8SkEu71QJyazlF5RcuMsda/
 vtxQ9mQ/E4BjjLBaY0dnGTtHRfirS5EWwI/1TmBTZgBCFpdLCWft1Lt7JDRcZAJM3eu0
 fLLecOr2iNMi6pNJtEN3479ry4GNyWI/RlFaL+iloAIY3HNRGU/Ci4piESxYZNwRMIQO
 IB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690482429; x=1691087229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oM3ayirwjADgOzG0Vn2+S8SWr4cG70rvwnLoTrmx2qw=;
 b=ltwivKX97Eb+bWVNK2e7318Fjs+6cgcJV8cLyh7vVtUEBg5sEy+qmJ6l9tt9w7ZSsm
 D85PYxxk8j0QU2XvMqjvLwIvYfTmwYBmbFdA/+MLpD6DJW11XhNDbSJhv26PxHybbjgB
 VPLV28PlKlqa0+I08zIBxo31cvEatf5/r+EDQa8Zkf9RelFCS2O6H9AxREmtg+dubbwv
 EBdjzu4t8ON2QfbQxYpsqW2FiPtCC+RBXE7QPtVp3KNrJ+Pf+YkaWuqD8QTIk17273C8
 DnewzPaGXr1682XGdCyqvZ7JMPV0diWqsgM/71dw54Ue9lIO7TK40D4wysI7LuBBfB//
 0zlw==
X-Gm-Message-State: ABy/qLa55j/FYHalWUaCSDbDRQJIYoywn/tm7v1ybG65h/YPvwRQyWcK
 ixEscbPtIPahgKeaHrTCN//7siTUCP8AfYvvVfYo7aAE0gI=
X-Google-Smtp-Source: APBJJlEeXM3TAm9k6u/eU1PLERaykg4aNwvgSjs4uzl6K2hRbpr6Xh7r/8UGY7L12Jv+MZiL2dW/97MJujev2b+zPLQ=
X-Received: by 2002:a05:6870:7386:b0:1b0:6cd8:1263 with SMTP id
 z6-20020a056870738600b001b06cd81263mr257950oam.48.1690482428735; Thu, 27 Jul
 2023 11:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230727172857.12780-1-mario.limonciello@amd.com>
 <CADnq5_OJ86xy3LOJo44tCWGWsGGAPc87epc3gSpkpbQefYKi5A@mail.gmail.com>
 <2d79bf17-925b-e19e-8cff-d37f8e736360@amd.com>
In-Reply-To: <2d79bf17-925b-e19e-8cff-d37f8e736360@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jul 2023 14:26:57 -0400
Message-ID: <CADnq5_NLdSHKKMMAizaJg__hwcX=ycZzHH=iTmK_kLHUyu+C0g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Disable S/G for APUs when 64GB or more host
 memory
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: roman.li@amd.com, amd-gfx@lists.freedesktop.org, Hamza.Mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 27, 2023 at 2:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/27/2023 13:02, Alex Deucher wrote:
> > On Thu, Jul 27, 2023 at 1:29=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Users report a white flickering screen on multiple systems that
> >> is tied to having 64GB or more memory.  When S/G is enabled pages
> >> will get pinned to both VRAM carve out and system RAM leading to
> >> this.
> >>
> >> Until it can be fixed properly, disable S/G when 64GB of memory or
> >> more is detected.  This will force pages to be pinned into VRAM.
> >> This should fix white screen flickers but if VRAM pressure is
> >> encountered may lead to black screens.  It's a trade-off for now.
> >>
> >> Fixes: 81d0bcf990093 ("drm/amdgpu: make display pinning more flexible =
(v2)")
> >> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> >> Cc: Roman Li <roman.li@amd.com>
> >> Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add =
S/G display parameter")
> >> Cc: <stable@vger.kernel.org> # 6.4.y
> >> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
> >> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v1->v2:
> >>   * Fix updating mode_info as well
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++=
++
> >>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++--
> >>   3 files changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index 93d0f4c7b560e..2e3c7c15cb8e3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,
> >>   void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
> >>   int amdgpu_device_pci_reset(struct amdgpu_device *adev);
> >>   bool amdgpu_device_need_post(struct amdgpu_device *adev);
> >> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
> >>   bool amdgpu_device_pcie_dynamic_switching_supported(void);
> >>   bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> >>   bool amdgpu_device_aspm_support_quirk(void);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index dc0e5227119b1..a4e36b178d86c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -1296,6 +1296,31 @@ bool amdgpu_device_need_post(struct amdgpu_devi=
ce *adev)
> >>          return true;
> >>   }
> >>
> >> +/*
> >> + * On APUs with >=3D 64GB white flickering has been observed w/ SG en=
abled.
> >> + * Disable S/G on such systems until we have a proper fix.
> >> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> >> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
> >> + */
> >> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
> >> +{
> >> +       switch (amdgpu_sg_display) {
> >> +       case -1:
> >> +               break;
> >> +       case 0:
> >> +               return false;
> >> +       case 1:
> >> +               return true;
> >> +       default:
> >> +               return false;
> >> +       }
> >> +       if (totalram_pages() << (PAGE_SHIFT - 10) >=3D 64000000) {
> >
> > Does totalram_pages() return the amount of physical ram or the amount
> > of usable ram (i.e., minus carveout, firmware reservations, etc.)?
>
> It's a good question.  I don't have a system w/ 64GB in front of me so I
> just double checked on a Phoenix system that has 16GB soldered down.
>
> It returns 15520248, so it's missing the VRAM carveout.  amdgpu does
> know this already via adev->gmc.real_vram_size.
> So I think the logic should be:
>
> if ((totalram_pages() << (PAGE_SHIFT - 10)) + (adev->gmc.real_vram_size
> / 1024) >=3D 64000000)
>
> That should bring it to ~16GB.

Yeah, that's probably good enough.

Alex

>
> > Assuming it does the right thing here:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >
> >> +               DRM_WARN("Disabling S/G due to >=3D64GB RAM\n");
> >> +               return false;
> >> +       }
> >> +       return true;
> >> +}
> >> +
> >>   /*
> >>    * Intel hosts such as Raptor Lake and Sapphire Rapids don't support=
 dynamic
> >>    * speed switching. Until we have confirmation from Intel that a spe=
cific host
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 77d970a2ee693..26c3eb7a9f882 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -1639,9 +1639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *=
adev)
> >>                  }
> >>                  break;
> >>          }
> >> -       if (init_data.flags.gpu_vm_support &&
> >> -           (amdgpu_sg_display =3D=3D 0))
> >> -               init_data.flags.gpu_vm_support =3D false;
> >> +       if (init_data.flags.gpu_vm_support)
> >> +               init_data.flags.gpu_vm_support =3D amdgpu_sg_display_s=
upported(adev);
> >>
> >>          if (init_data.flags.gpu_vm_support)
> >>                  adev->mode_info.gpu_vm_support =3D true;
> >> --
> >> 2.25.1
> >>
>
