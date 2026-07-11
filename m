Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1F1C43458
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 12:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9A510E34D;
	Sat, 11 Jul 2026 12:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W5XwaTNA";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A83410E34D
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 12:31:26 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7e9f5637634so1228637a34.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 05:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783773085; cv=none;
 d=google.com; s=arc-20260327;
 b=M/ReQImd4Jp5GrzS+4XMewIdEEj/TzHX0P9Y2A0+vBHcLkTveuP8ZEKMf0NJ/oTvy4
 kOIS1yL9C6aFWyCGyAJn0vg/psa7AnuJV+GJ0cMBTBRR0zhbd5Cwbefl6rNrRvHIH4/J
 KE+t+BMnU0ycFysmQzmClEYA18Zdifxa0rhS5RuUIn7YJvJRjqq+25KFuEKOS6a6FDQs
 KVcZC7lQI/HkfJRYBW1k/spBdMyK3UfHqnyKP7eEE1UVRRdF4+aRv/vUwt4EYwrSsaa4
 48kKKGYJwR4gEr9XfTTCIEAd4AiM9flKjNJuKVz1OKM/5O6/DAEKjJL/kqddTv1je5CX
 OUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2EeeykDCCrx2SOnEnd/AzM5Ou4PKDcI6pVbzZiwM5JY=;
 fh=sEMd3FpKKna/lfzTGdLllHN8Y5csUeypNnntGll0Pag=;
 b=ixdtXz9RZ4Hg8y5HlbBC1ru/IXMsi4OxeK/WNRFJWZjIZAh80l42nZzDt1hEvrKUFS
 M7sKEg1DTshEmwUo4o4knhANSPUz9Tkrcd50eD57kNqsrvUdx585OQer2sAtgEIJd4nM
 izl55MYTZd0YppH1+ubphzavW0jde/qo3Xm3ZPDI/0dJmNmR63+7YZIlkEcbUtsdso04
 eQz7mADAnGSHqX1CkiFgmpjUBfzW4F4zqW0TjZ+kvrCNJNIVwXBm/OKP7rd4mQuzYl8T
 p95NDikMlS8Qlvmr+jJEf2qu4INXtYtMjH/3kOD/oHCPWVlHBtEqMDnAwHd/wzm7EdcD
 BmIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783773085; x=1784377885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2EeeykDCCrx2SOnEnd/AzM5Ou4PKDcI6pVbzZiwM5JY=;
 b=W5XwaTNAS+ekaSSvmdrI/tufqb5/tcok/Kk3Mw7fW+Dmpsp8dJTEMsvPaGI1QcNLdz
 gYrdct1dK1VXKZvNpA2ranfI7jcLwndawK76Nwd9N27sKbg3ZK3mm7FVTs7uUuYcKJQO
 TbK9aYsj/QL+rIcqN6YXJYTn5mu6Cfh0tYct+RsOSo4oGrnqJXQdXQr+R5F6dxcc1rBI
 4DL7Lt4swWZDDPfj+BnE7Wg2KikFygT8dDkyeu3aC6/lUo/41BHJegNdnWxz4rhS1Y73
 po9HA+Vk4Nlfq8G2J7Y62ulqwy1udb2sgW+O4NKetW99V89NK0Sjt152SwyAG573Pq5V
 dc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783773085; x=1784377885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2EeeykDCCrx2SOnEnd/AzM5Ou4PKDcI6pVbzZiwM5JY=;
 b=Q4dgVvZYPqEnCeIgzOmhVwU2zpyCwjUacV9DZJZ+bh6/Td2VRmGJusO1vn1FxeNItw
 om+tdpLgbOsq+B9/2bLWocIod/iXN2fu8eQBKmXikcF9aw3mVl4ntTRk5PFYF3ZBb+yL
 YZulGIRucQn3Hcp40R8HXfJpXFly9WaMtmgGEwA4uFgmrmL+Y/WR3z5ChD6jgfmoJtWy
 D7rVCu+kUAehY/aHlugw8BYiX/D41aJ0Xl2opTa606mwoYZyXdtuGB8dWrzqi+0OZfZo
 X8TPHPFD5kR7rRi9p50HT5gvW8a327DuP9GuRgNLl0V65TegZGnA8aavSOy2bDcj1q78
 M2BA==
X-Gm-Message-State: AOJu0Yz+CrhMstNb/DI+r3oRmVsbp1A4tqhaB8NK9e7JP/3RuKBaPjQf
 jin4UWL0Y1MpWQLFLhEjdz8OrrX+7ah8W4NRjQYSjECiYRi3wPt/N1dCX9YbT24glM9/Hbmnic8
 vsbRfh64q3onFZ40OvojxCUyiprscu6o=
X-Gm-Gg: AfdE7ck4YpHCJmRWuZuYizMpaEpqNor6qtm6iiG740i8BH7GWeg2t6sVY6SD2x9Al64
 Q/e6VBtNkuNnyN3prZsId4OY0BSuLMrYoapYIOxC9Q/I6KEb3cvwH5EZHQarWLZY1S6o0Pf9rHS
 D8/k6zgLkgva/GqsOTIWfNxiDUtjNPYPxidb01ZA/+/ZUyjSsu5KE46EO4CtCEP/FhMn3BhIfSs
 3tIdG12mOKaNjLuvUSd4q+O+xin2XVqeFKwE7zXVNHByRmpq1AjKrjbXqWcEPQQII+LohJlbTk=
X-Received: by 2002:a05:6830:6af2:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7ec096390eamr1447323a34.9.1783773085360; Sat, 11 Jul 2026
 05:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260710025232.208861-1-vitaly.prosyak@amd.com>
In-Reply-To: <20260710025232.208861-1-vitaly.prosyak@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 11 Jul 2026 17:31:13 +0500
X-Gm-Features: AVVi8CcIAOtUwqGD-KLUV73cCS8gwAZCP9EdKYsRLu20Dz04w4dM83bkP5_GFCM
Message-ID: <CABXGCsOTTvRnyxBtLX_xDxX+Zve31-uE-qv=uBPRcC1x=rEW6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix lockdep false positive in
 amdgpu_lockdep_init
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

On Fri, Jul 10, 2026 at 7:52=E2=80=AFAM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Move fs_reclaim_acquire() to before all lock acquisitions to teach
> lockdep the correct dependency order and eliminate false positive
> circular locking dependency warning.
>
> PROBLEM:
>
> amdgpu_lockdep_init() trains lockdep by acquiring locks in sequence
> while calling fs_reclaim_acquire() in the middle. The fs_reclaim call
> was placed while notifier_lock was held, teaching lockdep:
>
>     notifier_lock -> fs_reclaim
>
> However, at runtime, MMU notifier callbacks run from inside memory
> reclaim, establishing the opposite dependency:
>
>     fs_reclaim -> mmu_notifier -> notifier_lock
>
> These form a false cycle that lockdep reports when reclaim unmaps a
> page covered by an amdgpu userptr notifier.
>
> LOCKDEP WARNING EXAMPLE (BEFORE FIX):
>
>     WARNING: possible circular locking dependency detected
>     6.19.0+ #48 Not tainted
>     amd_lockdep/3762 is trying to acquire lock:
>     ffff8881756f3c30 (&amdgpu_notifier_lock_key), at: amdgpu_hmm_invalida=
te_gfx
>
>     but task is already holding lock:
>     ffffffff92e4b5c0 (mmu_notifier_invalidate_range_start), at: try_to_un=
map_one
>
>     Chain exists of:
>       &amdgpu_notifier_lock_key --> fs_reclaim --> mmu_notifier_invalidat=
e_range_start
>
>     Possible unsafe locking scenario:
>           CPU0                    CPU1
>           ----                    ----
>      lock(mmu_notifier_invalidate_range_start);
>                                   lock(fs_reclaim);
>                                   lock(mmu_notifier_invalidate_range_star=
t);
>      lock(&amdgpu_notifier_lock_key);
>
>      *** DEADLOCK ***
>
> The dependency chain shows:
>   -> #5 (fs_reclaim):
>        amdgpu_lockdep_init+0x61e/0x730 [amdgpu]  <- FALSE EDGE
>   -> #0 (&amdgpu_notifier_lock_key):
>        amdgpu_hmm_invalidate_gfx+0x77/0x110 [amdgpu]  <- RUNTIME PATH
>
> SOLUTION:
>
> Move fs_reclaim_acquire/release to BEFORE all lock acquisitions.
> This teaches lockdep that fs_reclaim is outermost, matching runtime
> where reclaim calls MMU notifiers which then take notifier_lock.
>
> VERIFICATION (AFTER FIX):
>
> Test reproducer (based on Michael Gavrilov's standalone test case)
> creates a 64MB GPU userptr memory buffer, then repeatedly forces the
> kernel to reclaim it by moving pages to disk (simulating memory
> pressure). Each reclaim cycle triggers the MMU notifier callback path.
>
> The test would be available as an IGT subtest:
>   tests/amdgpu/amd_lockdep.c::notifier-reclaim-splat
>
> Results:
>   Before fix: Lockdep false positive warning on first reclaim attempt
>   After fix:  Completed 8 reclaim cycles with no lockdep warnings
>
> dmesg after fix shows only test success messages, no circular dependency
> warnings. The fix is minimal (relocate 2 lines) with no runtime overhead,
> only corrects lockdep's static analysis model.
>
> Reported-by: Michael Gavrilov <mikhail.v.gavrilov@gmail.com>
> Analyzed-by: Michael Gavrilov <mikhail.v.gavrilov@gmail.com>
> Test-case-by: Michael Gavrilov <mikhail.v.gavrilov@gmail.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: I584f833aaeac39d7eb777980f49ee503e70eb058
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 47 +++++++++++++++------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lockdep.c
> index 61450af539a6..718411f724f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -18,6 +18,7 @@
>
>  struct amdgpu_lockdep_dummy_locks {
>         struct mutex reset_lock;
> +       struct mutex filelist_mutex;
>         struct mutex userq_sch_mutex;
>         struct mutex userq_mutex;
>         struct mutex notifier_lock;
> @@ -34,6 +35,7 @@ static struct lock_class_key amdgpu_notifier_lock_key;
>  static struct lock_class_key amdgpu_vram_lock_key;
>  static struct lock_class_key amdgpu_reset_sem_key;
>  static struct lock_class_key amdgpu_reset_lock_key;
> +static struct lock_class_key amdgpu_filelist_mutex_key;
>  static struct lock_class_key amdgpu_srbm_lock_key;
>  static struct lock_class_key amdgpu_grbm_lock_key;
>  static struct lock_class_key amdgpu_mmio_lock_key;
> @@ -57,6 +59,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *ade=
v)
>         if (adev->reset_domain)
>                 lockdep_set_class(&adev->reset_domain->sem,
>                                   &amdgpu_reset_sem_key);
> +
> +       lockdep_set_class(&adev_to_drm(adev)->filelist_mutex,
> +                         &amdgpu_filelist_mutex_key);
>  }
>
>  /**
> @@ -74,9 +79,10 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *ad=
ev)
>   * 4. vram_lock           - VRAM allocator lock
>   * 5. reset_domain->sem   - GPU reset synchronization
>   * 6. reset_lock          - Reset control lock
> - * 7. srbm_mutex          - SRBM register access
> - * 8. grbm_idx_mutex      - GRBM index access
> - * 9. mmio_idx_lock       - MMIO index access (spinlock)
> + * 7. filelist_mutex      - DRM file list iteration (ddev->filelist_mute=
x)
> + * 8. srbm_mutex          - SRBM register access
> + * 9. grbm_idx_mutex      - GRBM index access
> + * 10. mmio_idx_lock      - MMIO index access (spinlock)
>   *
>   * Evidence:
>   * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
> @@ -88,6 +94,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *ade=
v)
>   *   must be outer to reset_domain->sem
>   * - vram_lock -> reset_domain->sem: VRAM management paths may need to
>   *   wait for ongoing reset to complete
> + * - reset_domain->sem -> filelist_mutex: GPU reset path
> + *   (amdgpu_device_gpu_recover) holds reset_domain->sem and calls
> + *   amdgpu_device_eventfd_signal_gpu_reset() which takes filelist_mutex
>   *
>   * Note: mmap_lock ordering relative to GPU locks is already taught
>   * by dma-resv (drivers/dma-buf/dma-resv.c).
> @@ -117,6 +126,7 @@ int amdgpu_lockdep_init(void)
>         mutex_init(&locks->notifier_lock);
>         mutex_init(&locks->vram_lock);
>         mutex_init(&locks->reset_lock);
> +       mutex_init(&locks->filelist_mutex);
>         mutex_init(&locks->srbm_mutex);
>         mutex_init(&locks->grbm_idx_mutex);
>         spin_lock_init(&locks->mmio_idx_lock);
> @@ -132,6 +142,7 @@ int amdgpu_lockdep_init(void)
>         lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
>         lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
>         lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
> +       lockdep_set_class(&locks->filelist_mutex, &amdgpu_filelist_mutex_=
key);
>         lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
>         lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
>         lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
> @@ -139,6 +150,18 @@ int amdgpu_lockdep_init(void)
>          * Take locks in the correct order to train lockdep.
>          * This establishes the dependency chain.
>          */
> +       /*
> +        * Train fs_reclaim FIRST, before taking any locks.
> +        * This teaches lockdep that fs_reclaim is the OUTERMOST context.
> +        * When memory reclaim later calls MMU notifiers (which take noti=
fier_lock),
> +        * lockdep will see: fs_reclaim -> notifier_lock (correct runtime=
 edge).
> +        *
> +        * Bug fix: Previously fs_reclaim_acquire() was called while hold=
ing
> +        * notifier_lock, teaching lockdep the FALSE edge: notifier_lock =
-> fs_reclaim.
> +        * This caused false positive circular dependency warnings.
> +        */
> +       fs_reclaim_acquire(GFP_KERNEL);
> +       fs_reclaim_release(GFP_KERNEL);
>
>         /* Level 1: Global userq scheduler mutex (outermost) */
>         mutex_lock(&locks->userq_sch_mutex);
> @@ -154,18 +177,16 @@ int amdgpu_lockdep_init(void)
>
>         /* Level 6: Reset control lock */
>         mutex_lock(&locks->reset_lock);
> -       /*
> -        * Mark potential memory reclaim boundary.
> -        * GPU operations might trigger memory allocation/reclaim.
> -        */
> -       fs_reclaim_acquire(GFP_KERNEL);
>
> -       /* Level 7: SRBM register access */
> +       /* Level 7: DRM file list mutex */
> +       mutex_lock(&locks->filelist_mutex);
> +
> +       /* Level 8: SRBM register access */
>         mutex_lock(&locks->srbm_mutex);
> -       /* Level 8: GRBM index access */
> +       /* Level 9: GRBM index access */
>         mutex_lock(&locks->grbm_idx_mutex);
>
> -       /* Level 9: MMIO index access (innermost lock, spinlock) */
> +       /* Level 10: MMIO index access (innermost lock, spinlock) */
>         spin_lock_irqsave(&locks->mmio_idx_lock, flags);
>         /*
>          * All locks acquired in order.
> @@ -176,8 +197,8 @@ int amdgpu_lockdep_init(void)
>         spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
>         mutex_unlock(&locks->grbm_idx_mutex);
>         mutex_unlock(&locks->srbm_mutex);
> -       fs_reclaim_release(GFP_KERNEL);
>
> +       mutex_unlock(&locks->filelist_mutex);
>         mutex_unlock(&locks->reset_lock);
>         up_read(&reset_domain->sem);
>
> @@ -190,7 +211,7 @@ int amdgpu_lockdep_init(void)
>         amdgpu_reset_put_reset_domain(reset_domain);
>
>         kfree(locks);
> -       pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\=
n");
> +       pr_info("AMDGPU: Lockdep annotations initialized (10 lock levels)=
\n");
>
>         return 0;
>  }
> --
> 2.54.0
>

Thanks Vitaly. Tested on amd-staging-drm-next (RX 7900 XTX, Ryzen 9 7950X)
with CONFIG_PROVE_LOCKING=3Dy + CONFIG_DEBUG_LOCKDEP=3Dy, via the
notifier-reclaim-splat subtest:

  - without this patch: the false circular-locking-dependency splat fires
    (&amdgpu_notifier_lock_key --> fs_reclaim --> mmu_notifier_invalidate_
    range_start), triggered from the subtest's madvise(MADV_PAGEOUT) path;
  - with this patch: no splat, and lockdep stays active for the whole boot
    (no module-load report from the reworked ordering either).

For the kernel fix:

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

The IGT subtest builds and behaves as intended (splat before, clean after),
so it works as a regression test.

A few small things:

- Could you s/Michael/Mikhail/ in all trailers, in both patches? The addres=
s
  is right but the first name is wrong and it will end up in git history:
  Reported-by / Analyzed-by / Test-case-by here, Based-on-patch-by in the I=
GT
  patch. It should be "Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>".

- Please add a Fixes: tag so this is linked to the regression:
      Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for
lock ordering validation")

- Minor, not a blocker: the moved fs_reclaim_acquire()/fs_reclaim_release()
  pair does not actually create a fs_reclaim -> notifier_lock edge, since n=
o
  lock is taken between the acquire and the release; it only registers the
  fs_reclaim class. The fs_reclaim -> notifier_lock ordering is established=
 at
  runtime when reclaim invokes the MMU notifier that takes notifier_lock,
  independent of this annotation. So functionally this is equivalent to jus=
t
  dropping the pair. The result is correct; only the comment ("teaches lock=
dep
  that fs_reclaim is the OUTERMOST context ... lockdep will see fs_reclaim =
->
  notifier_lock") overstates what the annotation does. Might be worth rewor=
ding.

One process question: 1d0f5838b126 landed in the 7.2 merge window, so this =
is a
7.2-cycle regression, while amd-staging-drm-next targets 7.3. Would it make
sense to route this fix to the 7.2 fixes stream so 7.2 does not ship with t=
he
false splat? The Fixes: tag would also let stable pick it up as a backstop.
Your call on the routing.

--=20
Thanks,
Mikhail
