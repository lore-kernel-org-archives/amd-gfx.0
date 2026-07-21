Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755E1C4452B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FF210E3A8;
	Tue, 21 Jul 2026 18:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbU8pu1j";
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8521410E3A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 18:09:53 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7eb6573bd52so6258528a34.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784657392; cv=none;
 d=google.com; s=arc-20260327;
 b=QveO04wJgGKXg2NrOgLv2jMeQk8JHRGerwPm2ONDptsFe+EQOeEh8iIpinQ7BGyCQp
 7P9Po0yLOHYq0sRFTa6LxofynlmkQNpId3KNG5Qv0UwI1sOMDu8Bn6bj+Snztgxzp4JX
 VexhD+erls88D/UHzyfbEhDZuKSsApJlC4+MQAMPH1LHjf+SwwCMrUK5Fqkd+7XcAjkX
 tT8p+A/41v97tShWcKmJ7NbDDKbxF4BO1qeNW1odycS8OuvkBeMPGf3bnIO5680tUbuE
 XMXoMA9XsOJh37P6DUvoJ+PPXaTb0D3GEmd5y9RAfamt3yomnR4VMBMs7QtYpcnj4+Qf
 olzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=657PTF+kjp07ScPIuFpyWerZ9DUGDt4h3eqh5FIi338=;
 fh=SwhwLCcbfM0wPvG0a6QOg8fd2iQIQujEbJG/Oxr+9CM=;
 b=igZLQCcvAPO9+nBilGM3vGtOQ0fca0DDwF9IRkfWYraQlmo3RNLrfduNQwaTj1s9q/
 oFF/ldCsrm8EOtGFxIcFfqkht/ZfqLkfvx/KURfXjTE5GBPXPDyTPhzdjl3xOpE/ha4s
 K4YHJnOS2YU3/P9L8QzaTWQa/PC7N/zR8L+bnQjdVbL+/XGbUswUodaHukru3p1kxcfW
 0kHzRaVpE3DqN6YUOOVgpmkm8bm9iLMBBp4QJBflpBaHs9SF/m1d6+HLtLbndmTUVJxT
 0jeEQEo23CD5XIJJjYuALf9k/kFlN3pvGXLGZIj+k4PX+AvklLyW+x/I0bYv2ED+D3ea
 HPBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784657392; x=1785262192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=657PTF+kjp07ScPIuFpyWerZ9DUGDt4h3eqh5FIi338=;
 b=JbU8pu1jQd8O8NQMr7vQOLDUKi01rn9un+wslWFdN9BWhnoL0B+zjQI13KxlNEKlCU
 huqZu6f7linZCJgK6V0UMydsxjYKpgO/wgqu9pPypIGeVUpaIBVhSceedNJtoSIX+Lfn
 WqOA8Psa0FtVlbvuG2r4CKAyoy2fc8oovsCYMnzqEsU7mLTSG/J3Au7R9GrvY4xsx+6A
 2YnH/RUindW2RCYm99qi1Kcq52S97UN6VLS5BVVBAGjVt1J7B+p1JfAcsc2+kQ37QMoK
 J6cpO9dm+6ysiGJ9wnGFDzG45T1jxvcgY/Fp2bvZx+spXtaj1pTmVd/wSKrtTZ3dZo2+
 YsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784657392; x=1785262192;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=657PTF+kjp07ScPIuFpyWerZ9DUGDt4h3eqh5FIi338=;
 b=hj+92u0hTm4Tb4bKK5bNhKtG6OrSH4L3aa0B7BszEEMCBmsHa1wTnwDdG0ny3dJMs3
 IbzJNfFnpXdgu6mpfxq+WB3tyhuVYBECf64gxRUEPKXcHXhnoaTQdW+5e9idDEA/iQVN
 6jrIykKZnVJb5nKgMe1jHspEcjzuSldEziD/NObCri667p51qSmm5+uHUmsUyYh2x3Au
 peuuSzXGl+SZOPQOKsk2NwPsqcT8X9+05jWjjK41ZcEUut2mz6GTNVL9NaUctmbTGnvW
 IQIhrLnfYQ7Imdah6lMnFdpXS69QCLZ7OX7XPw8TMPGxqOt87+AJ2o8K0GMvC4yNPH4V
 dhYg==
X-Gm-Message-State: AOJu0YxIlNZ9PxK3/CnH7hjbnSW3zKoLhJkb0PThs8zSNW2RF2ZyARAL
 vqIHnIyHYlkH23mE3PoY7pY1wPfaOJD3+ly3fFBg8gawzbWJgMUxlI75VZE2BZVgLhNkDIUsgZQ
 uhqE3tTzDuR6Uojk0RNyFl1/keRMLD1Y=
X-Gm-Gg: AfdE7cn59fSCDG9vKwunTtLusrCb5kR6hPb5sIZY7Xu9CeQV30f98Pw0uDQPsjKqNdT
 kzD7qKXtIFAYZTlekrDpIpT7TTJREpyFtZMvs3PfYJr94R8uwOscsvAErye/yvkNQm1tmmtgaOS
 /LrDdv/CjqkVgo856QHaRTBjayur/IJ0+Jnx8qdq6EUx+5y8X1Ci8rOKPdcPka6JA71DFtF3wvf
 K+jplLk1HdvW5hQQtGVsUJAKrjDVQbOrxoTucmPTe42aewJ3yASpiP91pNsPhRZ
X-Received: by 2002:a05:6830:3496:b0:7e9:c72e:e5d6 with SMTP id
 46e09a7af769-7eda084eaedmr11684574a34.14.1784657392489; Tue, 21 Jul 2026
 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260721001851.113927-1-vitaly.prosyak@amd.com>
 <20260721001851.113927-2-vitaly.prosyak@amd.com>
In-Reply-To: <20260721001851.113927-2-vitaly.prosyak@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 21 Jul 2026 23:09:39 +0500
X-Gm-Features: AUfX_mw6I8-srEOZv-ct3TaNXNnCqiGWYvw5PMQwSGtCQxNY5ldnuWYUg2R-rDE
Message-ID: <CABXGCsOsrFVyFEuOfUm5Vqpf64fbC3RifzGV2QDpGuP0o+gu8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix lockdep false positive in
 amdgpu_lockdep_init
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
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

On Tue, Jul 21, 2026 at 5:19=E2=80=AFAM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Move fs_reclaim_acquire() to before all lock acquisitions to eliminate
> false positive circular locking dependency warning.
>
> This is a 7.2-cycle regression fix suitable for stable backport.
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
> The acquire/release pair does not create a static lockdep edge by itself
> (no locks are held between acquire and release), but it registers the
> fs_reclaim lock class. The actual fs_reclaim -> notifier_lock ordering
> is established at runtime when memory reclaim invokes MMU notifiers that
> take notifier_lock. By moving the fs_reclaim registration before any
> lock acquisition, we avoid teaching lockdep the false reverse dependency.
>
> VERIFICATION (AFTER FIX):
>
> Test reproducer (based on Mikhail Gavrilov's standalone test case)
> creates a 64MB GPU userptr memory buffer, then repeatedly forces the
> kernel to reclaim it by moving pages to disk (simulating memory
> pressure). Each reclaim cycle triggers the MMU notifier callback path.
>
> The test is available as an IGT subtest:
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
> v2: Address Mikhail Gavrilov's review feedback:
>     - Fix author name: Michael -> Mikhail Gavrilov in all trailers
>     - Add Fixes: tag to link regression to original commit
>     - Add Tested-by: Mikhail Gavrilov (tested on RX 7900 XTX)
>     - Rewrite fs_reclaim comment to be technically accurate about what
>       fs_reclaim_acquire/release actually does (registers lock class,
>       doesn't create static edge)
>     - Add note that this is a 7.2-cycle regression for stable routing
>
> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock orderi=
ng validation")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Analyzed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Test-case-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lockdep.c
> index b251350b1fb2..718411f724f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -150,6 +150,18 @@ int amdgpu_lockdep_init(void)
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
> @@ -168,11 +180,6 @@ int amdgpu_lockdep_init(void)
>
>         /* Level 7: DRM file list mutex */
>         mutex_lock(&locks->filelist_mutex);
> -       /*
> -        * Mark potential memory reclaim boundary.
> -        * GPU operations might trigger memory allocation/reclaim.
> -        */
> -       fs_reclaim_acquire(GFP_KERNEL);
>
>         /* Level 8: SRBM register access */
>         mutex_lock(&locks->srbm_mutex);
> @@ -190,7 +197,6 @@ int amdgpu_lockdep_init(void)
>         spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
>         mutex_unlock(&locks->grbm_idx_mutex);
>         mutex_unlock(&locks->srbm_mutex);
> -       fs_reclaim_release(GFP_KERNEL);
>
>         mutex_unlock(&locks->filelist_mutex);
>         mutex_unlock(&locks->reset_lock);
> --
> 2.54.0
>

v2 looks good, thanks for fixing the name and adding the Fixes tag. No
objection from me.

One question on the comment above the
fs_reclaim_acquire()/fs_reclaim_release() pair, just so the annotation
file stays accurate. As written the pair is:

fs_reclaim_acquire(GFP_KERNEL);
fs_reclaim_release(GFP_KERNEL);
mutex_lock(&locks->userq_sch_mutex);
...

Since fs_reclaim is released again before any hierarchy lock is taken,
is it right that this pair does not actually create an fs_reclaim ->
notifier_lock edge? As far as I understand lockdep records an edge
only when a lock is acquired while another is held, so with nothing
taken between acquire and release the pair only registers the
fs_reclaim class. The real fs_reclaim -> notifier_lock edge then comes
from runtime, when reclaim invokes the MMU notifier that takes
notifier_lock (which your comment also calls the "correct runtime
edge").

If that is correct, the pair is functionally equivalent to just
dropping the old misplaced acquire, and the comment's "teaches lockdep
that fs_reclaim is the OUTERMOST context" slightly overstates what the
annotation does. Just wanted to check my understanding.

--=20
Best Regards,
Mike Gavrilov.
