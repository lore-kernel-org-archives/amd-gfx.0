Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E4C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 11:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A8E2065E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="e79Z4zty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A8E2065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E8F6E462;
	Wed,  2 Sep 2020 11:27:49 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5706E462
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 11:27:48 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id d189so4046466oig.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7SeoSPO3+8fzgBNJ+Mw4IKaW/dAbqbQSztz+/9HY+fY=;
 b=e79Z4ztyGSalXRixMyz9leyDsF3QT3GKbPCX0aC6iVjWTVQK3SfG8tfGqL+ndhTECG
 82BmIYsElcjEfwXEKb6vNGthbIyt8VlpPG71zft0w6JMtb65MhR3IymkV66TXyMWFNji
 AEBGzENzLvPZhxd0FhJgeWZ6bb0j7kOc2LObI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7SeoSPO3+8fzgBNJ+Mw4IKaW/dAbqbQSztz+/9HY+fY=;
 b=Wv02txa/fbm8XEmICX/Vp/2tHuQEh7nvd9bK5cxrf6Tnez7+Rlbl2bo/228/QObM/r
 SHmGro89OkR38FSwDJmLtHbRSn649giySRAqN3IX6/VtW4cUy2MK2PzY/Piu5cSyMCkv
 7aVzo66LghP9lyGCPf5QEkZgcAQ6+NypUcr0JHWPffF2VadxNdoorFZIk6BE7AteIZFu
 sCgfPfqdOcuFz99d8262BXZnyRVD/Qb2b+seoBZy4R5p4BVIKjvUmIW4caQ+30oG3uri
 Y9gUgqgI5XEuF3sLtTRwz1H/ouVmsL10N4ZKH0MIzK0fTVbE5j5dCYcp/iE3O1HPulKG
 DOsw==
X-Gm-Message-State: AOAM532i+ehSfOYNuDJmVsMFmPp2sw6UzpAF2FIZlQpxbqWYBn0eM7kE
 4+YuZk7KVUhcj5x9a/ozyLJc9Wq4+tvpkp0XYBjKGg==
X-Google-Smtp-Source: ABdhPJzkwNYQ+KIoBpDvEt6GTXpv0H3GZCLF5liPPUZpJt5ffzI/WIb7ML6WAvyHin4jjgotCpXY8mJck64t2kylzkQ=
X-Received: by 2002:aca:4306:: with SMTP id q6mr1694656oia.128.1599046067945; 
 Wed, 02 Sep 2020 04:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <SN1PR12MB25588CE66B9F67BBAED67655872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
 <CADnq5_NPNR2OAekTndORuKpzTP13Tx_KMNcnKLG8jB8O9fw8og@mail.gmail.com>
 <93da33fe-3157-3267-098d-4c4726b8cff3@amd.com>
In-Reply-To: <93da33fe-3157-3267-098d-4c4726b8cff3@amd.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 2 Sep 2020 13:27:37 +0200
Message-ID: <CAKMK7uGvmEj=hP=ztEK_FCH7BYpWT+JCtLSrcc0f2cFsPuMMrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a redundant kfree
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 1, 2020 at 10:35 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-09-01 10:12 a.m., Alex Deucher wrote:
> > On Tue, Sep 1, 2020 at 3:46 AM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
> >>
> >> [AMD Official Use Only - Internal Distribution Only]
> >>
> >> drm_dev_alloc() alloc *dev* and set managed.final_kfree to dev to free
> >> itself.
> >> Now from commit 5cdd68498918("drm/amdgpu: Embed drm_device into
> >> amdgpu_device (v3)") we alloc *adev* and ddev is just a member of it.
> >> So drm_dev_release try to free a wrong pointer then.
> >>
> >> Also driver's release trys to free adev, but drm_dev_release will
> >> access dev after call drvier's release.
> >>
> >> To fix it, remove driver's release and set managed.final_kfree to adev.
> >
> > I've got to admit, the documentation around drm_dev_init is hard to
> > follow.  We aren't really using the drmm stuff, but you have to use
> > drmm_add_final_kfree to avoid a warning.  The logic seems to make
> > sense though.

I've just resent the patch which should clarify all this a bit.

And the warning isn't there just for lolz, if you enable KASAN it will
report a use-after-free if you don't set this all up correctly. Note
that drmm_ is already used by drm core code internally for everyone.
-Daniel

> > Acked-by: Alex Deucher <alexancer.deucher@amd.com>
>
> The logic in patch 3/3 uses the kref infrastructure
> as described in drm_drv.c's comment on what the DRM
> usage is, i.e. taking advantage of the kref infrastructure.
>
> In amdgpu_pci_probe() we call drm_dev_init() which takes
> a ref of 1 on the kref in the DRM device structure,
> and from then on, only when the kref transitions
> from non-zero to 0, do we free the container of
> DRM device, and this is beautifully shown in the
> kernel stack below (please take a look at the kernel
> stack below).
>
> Using a kref is very powerful as it is implicit:
> when the kref transitions from non-zero to 0,
> then call the release method.
>
> Furthermore, we own the release method, and we
> like that, as it is pure, as well as,
> there may be more things we'd like to do in the future
> before we free the amdgpu device: maybe free memory we're
> using specifically for that PCI device, maybe write
> some registers, maybe notify someone or something, etc.
>
> On another note, adding "drmm_add_final_kfree()" in the middle
> of amdgpu_pci_probe() seems hackish--it's neither part
> of drm_dev_init() nor of drm_dev_register(). We really
> don't need it, since we rely on the kref infrastructure
> to tell us when to free the device, and if you'd look
> at the beautiful stack below, it knows exactly when that is,
> i.e. when to free it.
>
> The correct thing to do this is to
> _leave the amdgpu_driver_release()_ alone,
> remove "drmm_add_final_kfree()" and qualify
> the WARN_ON() in drm_dev_register() by
> the existence of drm_driver.release() (i.e. non-NULL).
>
> I'll submit a sequence of patches to fix this right.
>
> Regards,
> Luben
>
> >
> >>
> >> [   36.269348] BUG: unable to handle page fault for address: ffffa0c279940028
> >> [   36.276841] #PF: supervisor read access in kernel mode
> >> [   36.282434] #PF: error_code(0x0000) - not-present page
> >> [   36.288053] PGD 676601067 P4D 676601067 PUD 86a414067 PMD 86a247067 PTE 800ffff8066bf060
> >> [   36.296868] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
> >> [   36.302409] CPU: 4 PID: 1375 Comm: bash Tainted: G           O      5.9.0-rc2+ #46
> >> [   36.310670] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
> >> [   36.320725] RIP: 0010:drm_managed_release+0x25/0x110 [drm]
> >> [   36.326741] Code: 80 00 00 00 00 0f 1f 44 00 00 55 48 c7 c2 5a 9f 41 c0 be 00 02 00 00 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 08 <48> 8b 7f 18 e8 c2 10 ff ff 4d 8b 74 24 20 49 8d 44 24 5
> >> [   36.347217] RSP: 0018:ffffb9424141fce0 EFLAGS: 00010282
> >> [   36.352931] RAX: 0000000000000006 RBX: ffffa0c279940010 RCX: 0000000000000006
> >> [   36.360718] RDX: ffffffffc0419f5a RSI: 0000000000000200 RDI: ffffa0c279940010
> >> [   36.368503] RBP: ffffb9424141fd10 R08: 0000000000000001 R09: 0000000000000001
> >> [   36.376304] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0c279940010
> >> [   36.384070] R13: ffffffffc0e2a000 R14: ffffa0c26924e220 R15: fffffffffffffff2
> >> [   36.391845] FS:  00007fc4a277b740(0000) GS:ffffa0c288e00000(0000) knlGS:0000000000000000
> >> [   36.400669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   36.406937] CR2: ffffa0c279940028 CR3: 0000000792304006 CR4: 00000000003706e0
> >> [   36.414732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> [   36.422550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> [   36.430354] Call Trace:
> >> [   36.433044]  drm_dev_put.part.0+0x40/0x60 [drm]
> >> [   36.438017]  drm_dev_put+0x13/0x20 [drm]
> >> [   36.442398]  amdgpu_pci_remove+0x56/0x60 [amdgpu]
> >> [   36.447528]  pci_device_remove+0x3e/0xb0
> >> [   36.451807]  device_release_driver_internal+0xff/0x1d0
> >> [   36.457416]  device_release_driver+0x12/0x20
> >> [   36.462094]  pci_stop_bus_device+0x70/0xa0
> >> [   36.466588]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
> >> [   36.472786]  remove_store+0x7b/0x90
> >> [   36.476614]  dev_attr_store+0x17/0x30
> >> [   36.480646]  sysfs_kf_write+0x4b/0x60
> >> [   36.484655]  kernfs_fop_write+0xe8/0x1d0
> >> [   36.488952]  vfs_write+0xf5/0x230
> >> [   36.492562]  ksys_write+0x70/0xf0
> >> [   36.496206]  __x64_sys_write+0x1a/0x20
> >> [   36.500292]  do_syscall_64+0x38/0x90
> >> [   36.504219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +---------
> >>  1 file changed, 1 insertion(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index c12e9acd421d..52fc0c6c8538 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -1165,7 +1165,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> >>  if (ret)
> >>  goto err_free;
> >>
> >> -drmm_add_final_kfree(ddev, ddev);
> >> +drmm_add_final_kfree(ddev, adev);
> >>
> >>  if (!supports_atomic)
> >>  ddev->driver_features &= ~DRIVER_ATOMIC;
> >> @@ -1221,13 +1221,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
> >>  drm_dev_put(dev);
> >>  }
> >>
> >> -static void amdgpu_driver_release(struct drm_device *ddev)
> >> -{
> >> -struct amdgpu_device *adev = drm_to_adev(ddev);
> >> -
> >> -kfree(adev);
> >> -}
> >> -
> >>  static void
> >>  amdgpu_pci_shutdown(struct pci_dev *pdev)
> >>  {
> >> @@ -1522,7 +1515,6 @@ static struct drm_driver kms_driver = {
> >>  .open = amdgpu_driver_open_kms,
> >>  .postclose = amdgpu_driver_postclose_kms,
> >>  .lastclose = amdgpu_driver_lastclose_kms,
> >> -.release   = amdgpu_driver_release,
> >>  .irq_handler = amdgpu_irq_handler,
> >>  .ioctls = amdgpu_ioctls_kms,
> >>  .gem_free_object_unlocked = amdgpu_gem_object_free,
> >> --
> >> 2.25.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CLuben.Tuikov%40amd.com%7C5233b0caaac449417a7208d84e810de0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637345663485193534&amp;sdata=A%2FzJpoQmUhGBGts5mQfp%2BlVu1FL5NVbe5qfRelb2Og8%3D&amp;reserved=0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
