Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C63A606A688
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvJsLt/T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F1F10F73D;
	Tue, 24 Nov 2026 15:54:46 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BA310E23A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 13:52:00 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2f041f88577so24850775ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 05:52:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795528320; cv=none;
 d=google.com; s=arc-20260327;
 b=qn9YpsvrrP7kDIU8x9zfJ6w/OsvGsGX9Z29903QCPl5Im5adJMGoHA0pZaPbjfMm7P
 TgeLHcz9vtdzqQL02SKQuWstz/4BS/6w9U7rXepPaJNvcf/cWJaYeWDprBZ8IzK98kAg
 s/X8S7L47zThbiO9vxQXOuya867S9GCYG6ferFo84t8dJGN1YRePCeIo22mu2xTvr30w
 XT0LRoVXNmjVjGqcbK959pp3M9dEIFCnFOZ4YRIwaN6FG5Xr8yF8FGlNpxufOUEZ3+CW
 jdKjKwZmDWGiAbUvZhQq72uFU0BQxEoPBf5VtQMHQdPy5/ax58NwUEmGr0/0Bfwfdy4d
 1doQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Omccw5nXQpbWugrtlWE4yRONO+O5CY6YrSQySr4wqZE=;
 fh=hT8dyaGAI6nH/GjLpyrYSsNG1IB9nxBsK7SstjWKve8=;
 b=LU5TUoKMvlgAV4Z+5KWbPSWrsMwqHs08w9MgSn33lc1yLmbMCOzslQ/SPCjduFxQ/o
 lKpU50ANDZ563Oav2LN4VmEBDvCvrBYLctCnCNHZmQ3B7/5Zeg/6ALdRwGDxn44PoQ8a
 xvh4JouB+IAU2ewX0xIqyINab7mLlF3CnUl2gD0a00ftt4fcyTVFETONBcpnwp23Lcwf
 L/TzIVwuB3gcb+67PIZugrjoOwad07bbv6L6sh2GuriOkTxWtDb/qqCOlKzVQ9ee8kQc
 FPsTTcBdZPsC1WP6566mM9KUPaYjso/XictZGHMPIANRM9JuruOspkmZaNa2uRik3YmI
 c2tQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795528320; x=1796133120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Omccw5nXQpbWugrtlWE4yRONO+O5CY6YrSQySr4wqZE=;
 b=pvJsLt/TX6ox5VDL7Zscvps7ER3qCQi7zaak/k/k0eX8kKzU1J5TubWA5VbXEF1uFv
 LMwCXD88K4YghKwSUEGL8MQKLvzwNRskyFCK6QJtuIn7tCBt5eWWv00C9Lm781ZjO6D4
 GOKG5jXjSToOSQNTcbUmjD1WjAQmHZK7CDmSMPiN1Om8z/7jvrEIpYmMFXNuz3Zd8G25
 Ejf2cInDxZrdYH632dfK/Jo7tDLdbKvsQ3qJL2lxLKsyrkgOMcS7xIxR4lckY9SB8Pwa
 LJNRiEFrgwg/eH228fG3DbAzA7qwrQZlNr+wQ18XkLiBJVptrOSO+WO2vdzvd4XtBTQY
 q64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528320; x=1796133120;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Omccw5nXQpbWugrtlWE4yRONO+O5CY6YrSQySr4wqZE=;
 b=bDtUJvR4pdU4ifmr5yH9cU7ufrzwIxmAcnYWCHDnwAhFKK+H5dK/dSjBQBmo5m2tNp
 mxoIyH7Ph9TH66fewxXHc+FX54O/6cwhc2UMqQopes/8tZ4lnRkPEAtsCamm3h5sPN+A
 6HM+qXB5gADCpoSSv4L/oK7AUMxIlVLPxDf4LulLuVGwh/hnEajecypy/c/VRmU/mITR
 FGxopNjRPkCfa47AsTzOOBbxZmMSaWv9U511t4QOQr23cAECm5VWVKIojxz+av6U7Ywp
 IJFXwgvXS4C5izrr9VmaRIOcKQd06vKa2MBnBc8OmuO2id0xf4bHP+MmvWwvuwL3PoIQ
 +bWQ==
X-Gm-Message-State: APuU4Z+OdrAjLv+qKhDAl2Y7RbtsTB0gHVuQHOKfGcWPgIWETMwYShZH
 Qxx19RQjYhfFdhlWRn8pU0nDSw7z8HtuVTwPItpkFmh0EvvckgBY0XT1VlC7NOmMsWCeQvLRQKF
 nOE3thhzIhBbHfG/AhDvCl43VlK0BUdG2On7ESTDuDg==
X-Gm-Gg: AZFdTZcAhItfP5WRh47EDK7ugKFVX6WA2E29fFtJd5eaWBn8CzkvV1Rf8vGLJ+CXw31
 PCHNMiA9Vzktf15MSyMLTtcoUzvMMTAVRxkLTBENXfuEMx2U6vzoqyHS7OH0Y3v3Xtqxcx3Dfhd
 DcBwxejjSNPpOdSiCsnx/7u6GT442Iw067xdlbQAy8/d4YaYWLGJx3Om8JYkJN66rWEBkmcqcgV
 TNr6zxkUwNrqWvEBAEhi9Lk1QBnn0G3Vy11I10XfJZZeryWVt2nI1uG+xFNZa55CK8k5++QLc5X
 FWeI6hlD6K0nWYeS21CzP5gBmqQBdYOJJGFRJDSlPj8yi987nIJ2WtYtSDv8eNK1126OYrbnPTc
 SlCL+lEn/ZTZFvrvOrjUSzxd3A74rQycMq9uhTPioDSRkmyTh3Dq5AS6zCFcYrTdGEJIGVv0DS6
 mwhtrn/Ntf4FLwv/kBa7ZJl5XF
X-Received: by 2002:a17:902:f551:b0:2f0:2ba0:3b9a with SMTP id
 d9443c01a7336-2f03f1bfc54mr145240865ad.38.1795528319690; Tue, 24 Nov 2026
 05:51:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
 <20261124130258.1270242-1-arisa.snowbell@gmail.com>
In-Reply-To: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
From: Arisa Snowbell <arisa.snowbell@gmail.com>
Date: Tue, 24 Nov 2026 14:51:48 +0100
X-Gm-Features: Aa3M54p3jqS3NcWdHkFl-nXqZSmP-GG7B8wjKOK_TsE4oiSgRNJdImUQ5AFwYrs
Message-ID: <CABpa4MAcMp2TmHVg_8WabEW5vmYQyOL3J7yiFKu-jTXb5JwX_g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/userq: queue the restore worker on a
 freezable workqueue
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>, 
 Sunil Khatri <Sunil.Khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Turns out I found the answer to my own question while testing, sorry
for the extra mail. v2 on its own isn't enough: with Hyprland on user
queues, the first S3 resume failed when amdgpu_userq_resume() mapped
the queues again:

  MES(0) failed to respond to msg=3DADD_QUEUE fence_wait_ret=3D0 status=3D0=
x0_0
  [drm:mes_userq_map [amdgpu]] *ERROR* Failed to map queue in HW, err (-110=
)
  amdgpu 0000:03:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110

With the restore worker frozen, the BOs are still evicted at that
point. Queuing the restore worker for evicted processes, instead of
mapping their queues in resume, fixes it for me: the desktop and a game,
both on user queues, came back fine after resume. I'll send that as v3
after a few more suspends.

Thanks,
Arisa

On Tue, Nov 24, 2026 at 2:04=E2=80=AFPM Arisa Snowbell <arisa.snowbell@gmai=
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
> Fixes: 44cfdf368fb7 ("drm/amdgpu: resume gfx userqueues")
> Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
> ---
> v2: drop the restore block flag and the resume changes, only move the
>     restore worker to system_freezable_wq (Christian). v1 claimed that
>     for hibernation dpm_prepare() runs before freeze_kernel_threads(),
>     which is wrong.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
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
> index 9fc8e9e97595..f52c2096c5b4 100644
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
> --
> 2.56.1
>
