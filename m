Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27DCCC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8519310E10E;
	Fri, 16 Oct 2026 13:46:27 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C39A10E25F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:46:21 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-313bab9cfe7so837491eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 06:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792158380; cv=none;
 d=google.com; s=arc-20260327;
 b=aV9HamMrXhI3oJKB0PYQcRR9M3cA5GBl9CcOrh6K/kSdVqWLHcigHf5CYm3mLEOafu
 ao0JPCjFPiEG6K8vru+8eISB4DZs/7kh9tETu+yvCwiM8XZgW5C9+8BbcS9ByQ0z3kkg
 m23jmDy9VmG5IDb9iQH6s9cf2BPxhZwimq8zARnzlEXvSgvh88Lq+bVfVJhavs9jRCwm
 z8xmTEQJnG4w4eNmxHYkeiNeHXGA1j0XHQf3dJlkGBbAbbiChLduWfSzEqZSKI60qIYL
 h1YnlCL+XzSL0+c2Q7SANmD7Ddl2Zs/XT1yOBgk1OHL3vvgyRVkaRz1lSgRF+D/38R+0
 pcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IQwutrotEhcZFsSETctJaN2PlsZ4N4GXMfVQMj/m4xY=;
 fh=P3Hl2eKxDYQPVgqgI1Hm5k7DyCjNM8y+gbQw46xRkvg=;
 b=dy+5Fh1mlz00Jz+KzqsW7gd14b8P+krtjmsXUn/DIRrwv2d1qb1Ft04kPp+TZSpd1j
 LVbWAo+VZ/iP9IOYQQeD/6k8h4rJtkpGw7T+CKvST7bHHP5RyQWciS+26Cfs40LrQZlf
 4jpdg4Rq83GinCkxAiTUp1EsTtT5iCTM6TWfpCPgVN94EY95bdbRz2r3whW820xxZ1jG
 h7E0yRScOz8BiO/7+YYGnj0tq5fBTZVi1a95MAflsZSu9HAqcs2h8aB+ydXBaqCfkV2T
 KsufzDWgiuyXemiZk4/elxMXp2y6fQ1bc6EA8oJkJaaLcDEmXTkwo22ZnInKUh6SVwjU
 rypw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792158380; x=1792763180; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IQwutrotEhcZFsSETctJaN2PlsZ4N4GXMfVQMj/m4xY=;
 b=ijF4LyMqGGI6Kp+/Blihli8cjCmY/6Zus42bJRzSF9xjaceuW8b0Pghi6Y38xlKd04
 ffD8YbmQcEJhjos2oSwvPvyfj1EFQPWtHXqgHl7eptfCE5ywM7EI4O5ggoteZPhGwptZ
 pLWsSkf0b08dcnT2/kR+VxjKZTTnuaR0648Kl3EXH9VS9u+53hj3yduZhOCat823CCwK
 fTfzN2vuVuQ7nmE3JBfVAowAsiNT6w3oux9dUb9EOp84ZY1XhZTnu9XWG2J4b39U5P9c
 Ikxps8GL6406NPz8hf2qEALa2/HUkLjWvGPhZxIUBn7ta+nhajNZGJT8P5lUTgjyeLAh
 iTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158380; x=1792763180;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IQwutrotEhcZFsSETctJaN2PlsZ4N4GXMfVQMj/m4xY=;
 b=yHEv4ujg/gOzu2mLHy5KlQMWLVD7/vfc3qPKhwzqdcwtT55H9cH+9ny9FwyYtlXJf6
 BQ4EYG2OxCB8brCjI1N87OjGiiC/Unz/1RpT4R9cTFeFo5r0FqaUMzV0pLF0XqFyyf2I
 q6+gpgfDWhtfIQBYhkrZ8T/03GHjbsNRqQcRWcaR2tfCFJfiW8bH7AcahUJvD5DFINzr
 UojtXHogg2aVrQIdxHQJPYSpoUGXyWPHOzf0vh9h5kujD/GLyDoqXFK0VDhAAztWVMrN
 KKAF4WRXy2zLjRBYYaYHEU+B1Hy+gHhKh+J7/ESj098XmC6ZH+F/ZmmGwo9khmV4+qXw
 C35g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpQmXgHjyl0e2tiyfyr8fSop3dVjbiRshTSjyvjP4Uiowt178HoFpRfSiWCCn2KcN3nMrIkN+i@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJvYLnFHzgOdUijezXiNHb45AWKqmQb4khTWsywPw930vRhqtBr
 IyNVDiRPv/dQp8/EetCqyM8nbjjhE1sFDvppQKkXIDE+xv4FFEp4rR6h5C9opi+pJh2HD4jp3Vl
 hzbS59/Af159Kxh7Ut4/ZTA6OM7d9VW91uaqo
X-Gm-Gg: AYBFou3pAOSKvwJpbPzRki/Sht//jjUx7kskEEks28Ytn2rRGNA6dWrPDwtU5TLug1W
 eiGHmxzhAILOJzKBi5BO5Wu6PGXdOlsSMu9lFrl5fQ8R90Hg023PyGM06+CXh5AFag9ZtG0gyxR
 dd06Wj160IpUwbgSUwetRMGtFzPY2T3/XA0gO3hxlv3Zxcn54HkpGBIKxvsJi/m+RC7DwY65Svo
 cykl9etbvV/l+Pg15Z7a4MAfiUMETjoAqlVROTN9zRJXl8BPXW88d0d0rUgbqVs/eKy51+pzYDw
 VjsoJon9xYUa6kmBCbPXv8E8WIMEzzIWOYlIYkSekxzJryBbbvwxmP2WOPDa/Bim+nq0HnMH9lu
 YWzk3qKzcZIt/OWl2HrEN+PLpm6lJIBCbVU4AwB3ziA==
X-Received: by 2002:a05:701b:2910:b0:143:8212:a43 with SMTP id
 a92af1059eb24-185105a89e4mr14750c88.1.1792158380316; Fri, 16 Oct 2026
 06:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261008204517.392180-1-jfisher84@gmail.com>
 <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
 <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com>
 <9114d572-62ef-4885-bb29-d40d37cf2d61@amd.com>
In-Reply-To: <9114d572-62ef-4885-bb29-d40d37cf2d61@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 09:46:07 -0400
X-Gm-Features: AclHuK-ytFanZGwdBY-gJ2-dp39BXO2RIXTCCSoeyuE7yFl3Gs7bQgyaapbhsJQ
Message-ID: <CADnq5_PSd2q2AX0m3cQHr-jiJiSc=pUjV1H6UUKUJC=AaRGX6Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: John Fisher <jfisher84@gmail.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>
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

Applied.  Thanks!

On Fri, Oct 16, 2026 at 5:11=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/16/26 05:25, John Fisher wrote:
> > Thanks Christian. Since I don't have commit access, I assume that if
> > all looks good the commit will be passed on to be applied?
>
> Alex usually picks those up after a few days and merges it into amd-stagi=
ng-drm-next.
>
> Regards,
> Christian.
>
> >
> > Thanks,
> > John
> >
> > On Fri, 9 Oct 2026 at 20:00, Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >>
> >> On 10/8/26 22:45, John Fisher wrote:
> >>> amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> >>> updates when a KFD process acquires it. It syncs "with the last SDMA
> >>> update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> >>> walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
> >>> VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
> >>> the seq64 mapping allocates at the render node's open) are added ther=
e
> >>> by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
> >>> amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
> >>> reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update=
(),
> >>> amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
> >>> clear that is still queued.
> >>>
> >>> When one is, the CPU writes the first entries of the new compute VM (=
the
> >>> KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, map=
ped
> >>> during ACQUIRE_VM) into a page directory the SDMA then clears. The
> >>> entries are gone, the handler's page is unmapped, and the first wave
> >>> save of any queue of the process faults in the SQC instruction fetch =
at
> >>> the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
> >>> PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, =
and
> >>> the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 th=
e
> >>> queue is reset instead.
> >>>
> >>> The window is the time between the render node's open and ACQUIRE_VM.
> >>> ROCr spends milliseconds there and is practically never hit; a minima=
l
> >>> KFD client that opens the render node and acquires the VM at once is =
hit
> >>> most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, s=
o
> >>> vm_update_mode defaults to CPU updates for compute VMs), a wave readi=
ng
> >>> the trap handler's page right after queue creation found it unmapped =
in
> >>> 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that =
0
> >>> of 9, and the same sleep after queue creation instead 3 of 3.
> >>>
> >>> The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
> >>> promote the implicit sync to the dependent read fences") narrowed
> >>> amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_REA=
D;
> >>> the VM's page table jobs have been added with BOOKKEEP since commit
> >>> 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
> >>> v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
> >>> them.
> >>>
> >>> Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
> >>> with its updates, and wait for it, uninterruptibly, before switching =
the
> >>> update functions. The clears all go through vm->delayed, so the last =
one
> >>> covers the earlier ones; immediate clears are not recorded, as before=
.
> >>>
> >>> With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
> >>> 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of=
 5
> >>> runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
> >>> complete on 7.3-rc6, and two processes with 8 queues each complete
> >>> together on both, with no fault.
> >>>
> >>> Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the de=
pendent read fences")
> >>> Cc: stable@vger.kernel.org # v6.16+
> >>> Cc: Prike Liang <Prike.Liang@amd.com>
> >>> Signed-off-by: John Fisher <jfisher84@gmail.com>
> >>
> >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>
> >>> ---
> >>> v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now recor=
ds
> >>>     the clears, instead of every BOOKKEEP fence on the root PD; wait
> >>>     uninterruptibly without checking the result; keep the original
> >>>     comment (Christian)
> >>> v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84=
@gmail.com/
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >>>  2 files changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm.c
> >>> index 29187fabc..757a037ed 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_devic=
e *adev, struct amdgpu_vm *vm)
> >>>
> >>>       if (vm->use_cpu_for_update) {
> >>>               /* Sync with last SDMA update/clear before switching to=
 CPU */
> >>> -             r =3D amdgpu_bo_sync_wait(vm->root.bo,
> >>> -                                     AMDGPU_FENCE_OWNER_UNDEFINED, t=
rue);
> >>> -             if (r)
> >>> -                     goto unreserve_bo;
> >>> +             dma_fence_wait(vm->last_update, false);
> >>>
> >>>               vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >>>               r =3D amdgpu_vm_pt_map_tables(adev, vm);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm_pt.c
> >>> index c03327f12..cdbc2e931 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>> @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
> >>>       if (r)
> >>>               goto exit;
> >>>
> >>> -     r =3D vm->update_funcs->commit(&params, NULL);
> >>> +     r =3D vm->update_funcs->commit(&params, &vm->last_update);
> >>>  exit:
> >>>       drm_dev_exit(idx);
> >>>       return r;
> >>
>
