Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC395606A332
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPDVEAN3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB81F10F757;
	Tue, 24 Nov 2026 15:54:56 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC66410E875
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:16:47 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8a60f90a924so1738525b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 06:16:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795529807; cv=none;
 d=google.com; s=arc-20260327;
 b=MOKa72Fq+f3MM76sask5Y0oTIiEWCSl++Z1kWGddS+EjehGnU55WMz9mwk/UkXSAgO
 cW2GvOk7nZApY5FpSWI17xL5xQcunrtox32GPVZM4WrNzg4UUH+BWPJx8T2MyfsTa0zP
 9IfbzsrCQHvz7dulMrD5C00xAFagpQtxyw8KYwoBv+Fd27h8DudeWc3ihxYhtoXEmMu5
 ES6hxBVTt+HbsfrkysDZ48ltm/ln8f6CYQFLT2Aep52QvBcd5co9cj8ER4OHaZpbA8FW
 Vaz3nvA7wyJVO8Wo/144t6whPWGfYUaNjHXpVz+QHNhcMqPO1DmFmK4g2MZCPdgFpOMD
 rNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z42eDVhsYB1rHBmngWfcUq5om032Ee721GXAVFDydKk=;
 fh=4BiCht7G49i0rwDkq3O655Tf8KHp7ylkDyhL/BFi9oU=;
 b=RuoSOeS6Moh/EP+eQFL1hSkRnCx5tx+2edRTXkBKmnz7+8bIhbFdI4vYlVm3EgG/yg
 VMRDuRTBN3uOFaLA0uVyth4MFwDZFEkTdxFxXrmlO7c6D/HoU4U+mRDRxVDoynU6XI4l
 k/NDpLFXXj0WiPgh8TVviO1hqiy58ZE1JuHyNy4AZQN+1ZuDGZVC8//6BAl/96sK6Cnc
 vusULxwh2B9ehgEplsRAt67BncN7/8MUTFxaOMYfU5I6UVup+lB11kgnHHIc7a6s5t3V
 D6Ao2uBoob0xaMFReEVYyyawmgEcHwsUwBaG8PbRoGDNxPH/W07VGqH0Da6n/aljeuF6
 jnSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529807; x=1796134607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z42eDVhsYB1rHBmngWfcUq5om032Ee721GXAVFDydKk=;
 b=vPDVEAN3VoMCZ4zeqF+//e2C/ua1jqa4fQYKUN2n7Ot3xOgs+DvbVMTQjo7vyY3bsz
 eWhp0FKID0ke71QCs+gE/jS6ZjQ8+aGKfB/AohLsNdrZJd89yySj/35gYQEMOjUoOkQx
 vbqn79nT3S1oeoLIQ/45rGGXPqr83kn+w6yDfcrC+GBtJrKdfu6PyXalwqI/v4XPL9oe
 eFJy9vx9pptekRitObBqah4FcKR2wvozxSX7sD9o7MdJgP09UuUHIS0ii6112OjBJWNZ
 gnrRbyCvj3aWi8TTOAJWLiUttUffjlynr2aiKW6hQ7Yd3cTZcH9RG387+p7mPdtJbrEf
 AJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529807; x=1796134607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z42eDVhsYB1rHBmngWfcUq5om032Ee721GXAVFDydKk=;
 b=SGtSSLjVRXo40NuvifyQ78uLPLWyLdAGENXp7EdRSmh9pHnK11AwgyOAH4z4nZt+kL
 zKHV3RWGkFDXOIP/6jiGKgU7ejersG0P0NNpLv2wkANgQcBYiJlo3VlQYYbjnnYclZWS
 8g0ahfeRmKPxNc4iPR8r7hMZtEHIZnxCuQj4+35rL9RofEH2GRXNgoHW1ntTgoX1fdF8
 S4eG335UpZ+/3HPuMPD9BNy1q1jZvzr8iZbnWZBVK1srEvDP20MIfCDm9W59GnpSoYcb
 Qd2AOzRAEGQbR7GIEa3cea52/RZAoL6N1VMMBXVE/n/lb9SIN9OThb42cK4Kfos3Sm4N
 YbLA==
X-Gm-Message-State: APuU4Z9xg8zXYMW59Ulq+JP92+SON9jWlgHP0SX9yy15jjYMSdmswakw
 YnYnbEtlxkdh9d7YbaoC47gZGMXI0AY4fU7N5g4eNOD3UkMiumdgUYAarK6/LATIyCrsUAYGd0Q
 X8a2b9L3YBNCpzctpJ+ZOw/zkFKq/PdK3PJxRYDjUbA==
X-Gm-Gg: AZFdTZflKSTBYTqgTDLtAaRJmgvk8u9uFiYJPJVM+mQP237Xe/cli1ji7bWIcy4ii0T
 qVz0/Oql5/atLjt0GlyZhRGvJPEEiwyVEmtZvwrqpcKqh8VOQybC5svpbtSLpg1BL5TQuy2DCNT
 J6ZDCF0CwOnFdnoz01A9e37FBbaDNMm1k0Cxr7ah9WUd601teBy8ki1/j1W3q1r+zD5R8AWallH
 uSXtKTaxZTZgNmtmww7Znoz/ZqjdtL7998Hqb2dt+F0A2XLytT1EdGRdx51I5yPagbOmRpMPKq6
 3p0sBIwA09uDMM8NfPkgmEeN495L07eMxdZCaWj66yPkKiDIXSmKQiVN3o2tT+RMYfo0ShVAxnM
 zdW6FmRWqy0lLCs0acwB00fBKY9hEz4fR7z3Eo2pnRRcBjdoUK1HmQEJEdlDlOcn7G5A46zsSi7
 HSgfvc9BcIxI78yQmHZwIfWr9yIP7MAcI26gkbCLUxA329NA==
X-Received: by 2002:a05:6a00:170d:b0:885:e2eb:23b6 with SMTP id
 d2e1a72fcca58-8c87b9cfab5mr13363809b3a.11.1795529807113; Tue, 24 Nov 2026
 06:16:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
 <20261124141416.11034-1-arisa.snowbell@gmail.com>
In-Reply-To: <20261124141416.11034-1-arisa.snowbell@gmail.com>
From: Arisa Snowbell <arisa.snowbell@gmail.com>
Date: Tue, 24 Nov 2026 15:16:36 +0100
X-Gm-Features: Aa3M54oJLLiEtyafnT2tQwMMUhIbLmLEZRerahnrdWj9-MEdu5nPQs633pVpdyE
Message-ID: <CABpa4MDEYZ29u-gCD__qQjCNwORXXXOkZbocaV5+izzL6jH9yw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu/userq: keep the restore worker out of
 system sleep
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>, Sunil Khatri <Sunil.Khatri@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Now that suspend works with user queues, I ran into another userq bug.
About ten minutes after a clean resume, while I was moving a window, the
eviction of Firefox's video decoder process failed because MES stopped
answering REMOVE_QUEUE:

  MES(0) failed to respond to msg=3DREMOVE_QUEUE fence_wait_ret=3D453176
status=3D0x81000301_0
  [drm:mes_userq_unmap [amdgpu]] *ERROR* Failed to unmap queue in HW, err (=
-110)
  comm: RDD Process pid: 6022 client-id:44 client: Unset ... Couldn't
unmap all the queues, eviction failed ret=3D-110

After the GPU reset that followed, the desktop locked up: the eviction
fence suspend worker sat in amdgpu_userq_wait_for_signal() holding the
userq_mutex, and Hyprland blocked on that mutex in
amdgpu_userq_ensure_ev_fence().

This patch doesn't touch that path, and I've seen MES time out under
heavy load without any suspend before, so I don't think the suspend
caused it. It's a separate bug, but suspend with user queues should be
working now. I'll try to reproduce it without suspending and grab the
devcoredump, then report it separately.

Sorry again for all the extra mails.

Thanks,
Arisa

On Tue, Nov 24, 2026 at 3:14=E2=80=AFPM Arisa Snowbell <arisa.snowbell@gmai=
l.com> wrote:
>
> Before system sleep, amdgpu_device_prepare() moves all BOs out of VRAM.
> When it evicts a BO of a process with user queues, the eviction fence of
> that process signals, and amdgpu_eviction_fence_suspend_worker() queues
> the restore worker on system_wq. That workqueue is not frozen, so the
> restore worker runs while the eviction is still going on and moves the
> BOs back into VRAM, waiting for the page table updates while it holds
> their reservations.
>
> On an RX 9070 XT (gfx12) this hung S3 suspend for good after a few hours
> of uptime. A restore worker waited forever on a page table update fence
> while holding the reservations, and systemd-sleep waited in
> ttm_bo_evict_first() for one of them.
>
> Queue the restore worker on system_freezable_wq, like the amdkfd restore
> workers. Its work is frozen before dpm_prepare(), so a restore queued
> during the eviction stays pending until amdgpu_userq_suspend() cancels
> it.
>
> The processes are then still evicted at resume, so amdgpu_userq_resume()
> must not map their queues: their BOs are not validated and their page
> tables are out of date. Mapping them made MES time out on ADD_QUEUE and
> the resume fail with -110. Queue the restore worker for them instead,
> which validates the BOs, rearms the eviction fence and maps the queues
> once the system is thawed.
>
> Fixes: 44cfdf368fb7 ("drm/amdgpu: resume gfx userqueues")
> Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
> ---
> v3: bring back the resume change from v1: amdgpu_userq_resume() does not
>     map the queues of processes whose BOs are evicted, and queues the
>     restore worker for them instead. With v2 alone, resume mapped them
>     with the BOs still evicted, MES timed out on ADD_QUEUE and the resume
>     failed with -110.
>
> v2: drop the restore block flag and the resume changes, only move the
>     restore worker to system_freezable_wq (Christian). v1 claimed that
>     for hibernation dpm_prepare() runs before freeze_kernel_threads(),
>     which is wrong.
>
> Tested with S3 on an RX 9070 XT, with the desktop (Hyprland) and a game
> on user queues: suspend and resume complete and the queues keep running.
> Rendering after resume is still corrupted (the game, and small artifacts
> on the desktop), but that also happens with kernel queues; I'll report
> it separately.
>
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index f8652fd0525d..18b11d7f457e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -91,7 +91,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct=
 *work)
>         dma_fence_put(ev_fence);
>
>         if (!evf_mgr->shutdown)
> -               schedule_delayed_work(&uq_mgr->resume_work, 0);
> +               queue_delayed_work(system_freezable_wq, &uq_mgr->resume_w=
ork, 0);
>
>         mutex_unlock(&uq_mgr->userq_mutex);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 9fc8e9e97595..4f41163a0a55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -456,7 +456,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr =
*uq_mgr,
>                  * Looks like there was no pending resume work,
>                  * add one now to create a valid eviction fence
>                  */
> -               schedule_delayed_work(&uq_mgr->resume_work, 0);
> +               queue_delayed_work(system_freezable_wq, &uq_mgr->resume_w=
ork, 0);
>                 goto retry;
>         }
>         dma_fence_put(ev_fence);
> @@ -1428,6 +1428,16 @@ int amdgpu_userq_suspend(struct amdgpu_device *ade=
v)
>         return 0;
>  }
>
> +static bool amdgpu_userq_evicted(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> +       struct dma_fence *ev_fence =3D amdgpu_evf_mgr_get_fence(&fpriv->e=
vf_mgr);
> +       bool evicted =3D dma_fence_is_signaled(ev_fence);
> +
> +       dma_fence_put(ev_fence);
> +       return evicted;
> +}
> +
>  int amdgpu_userq_resume(struct amdgpu_device *adev)
>  {
>         struct amdgpu_usermode_queue *queue;
> @@ -1438,6 +1448,13 @@ int amdgpu_userq_resume(struct amdgpu_device *adev=
)
>         xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>                 uqm =3D queue->userq_mgr;
>                 guard(mutex)(&uqm->userq_mutex);
> +
> +               /* The BOs moved, let the restore worker validate them fi=
rst */
> +               if (amdgpu_userq_evicted(uqm)) {
> +                       queue_delayed_work(system_freezable_wq, &uqm->res=
ume_work, 0);
> +                       continue;
> +               }
> +
>                 if (adev->in_s0ix)
>                         r =3D amdgpu_userq_restore_helper(queue);
>                 else
> --
> 2.56.1
>
