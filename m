Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08435C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5922207D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHvbdlNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5922207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3AF6E069;
	Tue,  1 Sep 2020 14:12:27 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD5E6E069
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 14:12:26 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id o21so1324201wmc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mwtj3n9ekE5abTPfjt0ogCWbDquzlILxV9gEL19/jLo=;
 b=UHvbdlNquI20hywcwO/tvLmozNgnXCmoZ9cUCyUUjwLPme3bp8mX2hX7zDElvnWwCk
 AQ38d1FtGX5GIgmRyUYeCro8EkSPFxYVHPZoZEMnePjWV9n3S+APvQB+N7miQni/f463
 Rejp1QnZcbgFqSPgzIqX+U/jNwLiwiMusGdLKXy6fjQIfbG7YrmrVLDOzUqpxMdbgmzS
 t/5Gcl2YPbB1sUzKYg4XL1RLEb6zec+lA9/pFl0jbezx46Qs6o0qafuV55loz0iWmhC1
 YgnHXQbxYiNUgSbFHlWomTAPHc5J9wBiXT9b5pLf0MM6rlsVOmLq9Q0Da7a88TI9tJuO
 AFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mwtj3n9ekE5abTPfjt0ogCWbDquzlILxV9gEL19/jLo=;
 b=M0sRC0zWjJghrUA+ryzvqK8d0UkPFbqIrsGqcfw98HN32PHDCFC5fzzyy2UjLc7qk4
 9xc3TGjg9wIgsLBEDewpHPW60AePkHYwA9vOFCSEi7EHluHMWCgTvc86faQSJaPPBqd/
 VHUHvYh033+VYCx4P64KRY+2sdutu0jMSVrea4FKX2GAl3UxEIZyIfKSGN0LLjGmxJlz
 IbaSqGGlqB40zmXg4PD2cIN4r8lTwR5jCFdR5l1ZswP59zcGyYVhaHZIYHTLTFoWjqIR
 qTYLmp0tjMCPuYtEaCyN9xySWRZub7wEkh2UXTATBruECVKm9aC2kQEjl9xDsFsoHn4G
 nG3A==
X-Gm-Message-State: AOAM530D+ww3AwCskVSw2gdeiMYg/pnnWa4P7oEmUpjPJJPAod77XsoY
 Ol1ibfIVDZHidNm93vNx7szxFWw3F5tO9Te44YI=
X-Google-Smtp-Source: ABdhPJz6W6v5ET+AEW3qKsS2jKiGbTzAwJxCG3+G/BBn7aDP2HYMLohx1+achSNUNQnx0r+HwsUtecVwLp9qSvVc0o0=
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr2031483wmh.56.1598969545091; 
 Tue, 01 Sep 2020 07:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <SN1PR12MB25588CE66B9F67BBAED67655872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB25588CE66B9F67BBAED67655872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2020 10:12:14 -0400
Message-ID: <CADnq5_NPNR2OAekTndORuKpzTP13Tx_KMNcnKLG8jB8O9fw8og@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a redundant kfree
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 1, 2020 at 3:46 AM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> drm_dev_alloc() alloc *dev* and set managed.final_kfree to dev to free
> itself.
> Now from commit 5cdd68498918("drm/amdgpu: Embed drm_device into
> amdgpu_device (v3)") we alloc *adev* and ddev is just a member of it.
> So drm_dev_release try to free a wrong pointer then.
>
> Also driver's release trys to free adev, but drm_dev_release will
> access dev after call drvier's release.
>
> To fix it, remove driver's release and set managed.final_kfree to adev.

I've got to admit, the documentation around drm_dev_init is hard to
follow.  We aren't really using the drmm stuff, but you have to use
drmm_add_final_kfree to avoid a warning.  The logic seems to make
sense though.
Acked-by: Alex Deucher <alexancer.deucher@amd.com>

>
> [   36.269348] BUG: unable to handle page fault for address: ffffa0c279940028
> [   36.276841] #PF: supervisor read access in kernel mode
> [   36.282434] #PF: error_code(0x0000) - not-present page
> [   36.288053] PGD 676601067 P4D 676601067 PUD 86a414067 PMD 86a247067 PTE 800ffff8066bf060
> [   36.296868] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
> [   36.302409] CPU: 4 PID: 1375 Comm: bash Tainted: G           O      5.9.0-rc2+ #46
> [   36.310670] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
> [   36.320725] RIP: 0010:drm_managed_release+0x25/0x110 [drm]
> [   36.326741] Code: 80 00 00 00 00 0f 1f 44 00 00 55 48 c7 c2 5a 9f 41 c0 be 00 02 00 00 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 08 <48> 8b 7f 18 e8 c2 10 ff ff 4d 8b 74 24 20 49 8d 44 24 5
> [   36.347217] RSP: 0018:ffffb9424141fce0 EFLAGS: 00010282
> [   36.352931] RAX: 0000000000000006 RBX: ffffa0c279940010 RCX: 0000000000000006
> [   36.360718] RDX: ffffffffc0419f5a RSI: 0000000000000200 RDI: ffffa0c279940010
> [   36.368503] RBP: ffffb9424141fd10 R08: 0000000000000001 R09: 0000000000000001
> [   36.376304] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0c279940010
> [   36.384070] R13: ffffffffc0e2a000 R14: ffffa0c26924e220 R15: fffffffffffffff2
> [   36.391845] FS:  00007fc4a277b740(0000) GS:ffffa0c288e00000(0000) knlGS:0000000000000000
> [   36.400669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   36.406937] CR2: ffffa0c279940028 CR3: 0000000792304006 CR4: 00000000003706e0
> [   36.414732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   36.422550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   36.430354] Call Trace:
> [   36.433044]  drm_dev_put.part.0+0x40/0x60 [drm]
> [   36.438017]  drm_dev_put+0x13/0x20 [drm]
> [   36.442398]  amdgpu_pci_remove+0x56/0x60 [amdgpu]
> [   36.447528]  pci_device_remove+0x3e/0xb0
> [   36.451807]  device_release_driver_internal+0xff/0x1d0
> [   36.457416]  device_release_driver+0x12/0x20
> [   36.462094]  pci_stop_bus_device+0x70/0xa0
> [   36.466588]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
> [   36.472786]  remove_store+0x7b/0x90
> [   36.476614]  dev_attr_store+0x17/0x30
> [   36.480646]  sysfs_kf_write+0x4b/0x60
> [   36.484655]  kernfs_fop_write+0xe8/0x1d0
> [   36.488952]  vfs_write+0xf5/0x230
> [   36.492562]  ksys_write+0x70/0xf0
> [   36.496206]  __x64_sys_write+0x1a/0x20
> [   36.500292]  do_syscall_64+0x38/0x90
> [   36.504219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c12e9acd421d..52fc0c6c8538 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1165,7 +1165,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  if (ret)
>  goto err_free;
>
> -drmm_add_final_kfree(ddev, ddev);
> +drmm_add_final_kfree(ddev, adev);
>
>  if (!supports_atomic)
>  ddev->driver_features &= ~DRIVER_ATOMIC;
> @@ -1221,13 +1221,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  drm_dev_put(dev);
>  }
>
> -static void amdgpu_driver_release(struct drm_device *ddev)
> -{
> -struct amdgpu_device *adev = drm_to_adev(ddev);
> -
> -kfree(adev);
> -}
> -
>  static void
>  amdgpu_pci_shutdown(struct pci_dev *pdev)
>  {
> @@ -1522,7 +1515,6 @@ static struct drm_driver kms_driver = {
>  .open = amdgpu_driver_open_kms,
>  .postclose = amdgpu_driver_postclose_kms,
>  .lastclose = amdgpu_driver_lastclose_kms,
> -.release   = amdgpu_driver_release,
>  .irq_handler = amdgpu_irq_handler,
>  .ioctls = amdgpu_ioctls_kms,
>  .gem_free_object_unlocked = amdgpu_gem_object_free,
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
