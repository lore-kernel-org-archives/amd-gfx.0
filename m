Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11635CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A8D10E49F;
	Tue, 26 May 2026 14:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="keesHlVp";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0CF10E49F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:08:32 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2eeafc50c87so687688eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804511; cv=none;
 d=google.com; s=arc-20240605;
 b=Xo7uJfVqLmWwEy7z4cJmLpsOdysCU/xn6wWcaSfQFFtqZay+V6grtFiqbuK5nqqUs/
 lJeuajOuHZLkm4QHykUn9aNX1DH2YcRwQXf7VkjpAdVtLwG+HCUeBhXg+XxeP66de912
 OKcQfIl5FzjDmQdGbDf4z6vWXdIG9KOwL2KK9xoyHuGaRS133iQ15v17cOa5s/83XwMr
 NvDXVNQ+UmfE8/aAiuLXluDMcRzc5vkOZlqTc7pvFfBLJBysdevtJE5uRugoXRCAvDPU
 Zc9lDwCX032mB0auvJodkuW7bXGko6eqOUeevkx+2jzd7y2K6hemPmgm16yo4cQ/MiKG
 fMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IFn7TjGrFdFg4E1SdXgOkHJZ1jdUmo5OnzDG6699atc=;
 fh=bB8/bQo9ht2SV7ZgIOYqB2hDYTyKPIqnuwA0H6wLB/Q=;
 b=YNFQYlWzRZu12UFINuS9aCOcGC7qvdgC+zejTGo4qky4berIYL/czvvl4dBjFNjvTQ
 aOs6KBwzb9VBCesy+WEwlrHDcVFpJQAmJVz8L6uIAxN0ig6OFt4qCGQKW1bExDuZ1/vO
 cIgyqmudAbv47aDMLlDrJ0rH1gG7doomKYpQqT8tWyRmeClgAFHi+AQbFMoqDrpqxA9Q
 Yb7+G1/TsqCSbOGTibU2xdg23SSGHlUWfy3LStGuHtqnyBNxn6lx4i+3UbnDzQ1kKH4E
 +3otTlmCZP5MezlavDsei3NQLK65Uv/7rQzxfv6vS+03VQzwKdlWVr6BZCjrBjq8tbEt
 rH4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779804511; x=1780409311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFn7TjGrFdFg4E1SdXgOkHJZ1jdUmo5OnzDG6699atc=;
 b=keesHlVpxuygA5WCYKyDR/1xCTU2Fv1MSFcE/x4k5AqESzNKnzmCpJpmX589D+VMKM
 72QKTYqy66PwhWPUwZoll8ouOn4gHJoJ4yFd2/yo04M9jP/ey4BL8zCM9g7GGaaLzAQ6
 dPXQNUSzAnLlR5S6hkhakV0OdBKoDzyly5EHp6bNA3BbfAodlcEDlGkbDpCszXQDFvyQ
 U3mpgntAqmiyGNxDFdaPASR/SH2h0w/eTcbA2PVOlt4s71ugngH6OZHDZXLmLCUehNMK
 lqXycI/9em0uoLh/ojuyJCH8fDgJExJBkwOPmCD+RVussh+gwDpwnpuZm/jY4qVOR0La
 BWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804511; x=1780409311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IFn7TjGrFdFg4E1SdXgOkHJZ1jdUmo5OnzDG6699atc=;
 b=Ecz3yEMiXK7myiJ43SjrVls7Qn6MDb1kIXG7yRXU1vl0iwjuButpRWhx54A6Yis28U
 CiDQTyL1lKvQlE0qoWoQjnxTLqPAW2N/omPiYC3ZdfYJq9VwZ7wCQi4/D76E7qfFApPa
 f6DpYwI+6HO+QyC1oCzJ8j3Z5VTw7VQD6zHGhhsO7W0mAPPRQ8SCCeMowDRdnXF5vMx9
 9Ax6Wo+3AmL53NRLurBc6rWclKtICChlznEaMZ3wWFIiaNkvd67eMVezW1ibbR5Q6/co
 bwXG9GZyEdkChjMQZNmlTWqUX3Gq9+lHAVHVKP/F0x5KiGYUcQfsGr0timpFe+lP6nJ1
 O6wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ztoKzRZKbJq2MYdpObNAZatQ8AyYs5OvSJsiCnVd+GXD7gv+qPh5DNnmIhMmoXEa+Pd9bxGdu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL47J61PWY5MZW9jizlwaZpLsQf75oMlT4gGp4FPFWnH3vpPs3
 vCME/u89H1/iWYYTUm2JUp10MdsRzQ97mzwY5XaEh/OCjt2RFyhksE3IdfuixQrnuutlzFhwibw
 8ByoahaiEfaZ+qRkIWTIgvTpPomH1IMI=
X-Gm-Gg: Acq92OEJfYciNh9AQ8dMqp/qpKXo9a/YnSyZYN/Ijo0a8Ze1CUA2ufF5zKskH7/e7ad
 qOmgfXT2TdeVqbMANeeFt1QBfFsrjYeCWc1/RDmXoNmWBPPOoCXpV8DlIiokbxQgxjTFGBXRfAT
 l1YFk6ZL8+B3/PIYUA924jg45Gy0tP6SYXTSmkMK8g/pGgoESI34WJrv4N/Kmotpst1sMCzDt0S
 vZrGMRp4V9NA+iA9BHrY0Kvaitr7uYFOnOKLdFRa2pmKMX3w7WMpX3qg+9FxwLsNT3WvfgJeDq5
 0bGug+Ogk80cXM9MtphSBUDLFwnitnY+TjHUkwPsjCUqjn7xS02/syZrRccDWg52vwYOMA==
X-Received: by 2002:a05:7022:322:b0:136:b71d:a90b with SMTP id
 a92af1059eb24-136b71dad32mr1389932c88.0.1779804511047; Tue, 26 May 2026
 07:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260522093147.11192-1-christian.koenig@amd.com>
In-Reply-To: <20260522093147.11192-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:08:18 -0400
X-Gm-Features: AVHnY4LRXKbApq_kue_CGvFwSt6APCDtJAP0mUnzXb1sZNb4utJds1Clih2njas
Message-ID: <CADnq5_NRizp+Wg1ZuLEXYYdT_fd8MVtiqWfGptbD1fd9k+q+2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine
To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Fri, May 22, 2026 at 5:39=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Can't splice the list but need to handle each entry individually.
>
> Otherwise we run into issues after a GPU reset.
>

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index b523a7b97d6f..e91504f04d97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -266,12 +266,23 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_b=
ase *vm_bo)
>   */
>  static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>  {
> +       struct amdgpu_vm_bo_base *vm_bo, *tmp;
> +
> +       /*
> +        * Don't use list splice here, we need the special handling for t=
he root
> +        * PD and set the moved flag appropriately.
> +        */
>         amdgpu_vm_assert_locked(vm);
> -       list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> -       list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved)=
;
> +       list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
> +               amdgpu_vm_bo_moved(vm_bo);
> +       list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_s=
tatus)
> +               amdgpu_vm_bo_moved(vm_bo);
>
>         spin_lock(&vm->individual_lock);
> -       list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +       list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_sta=
tus) {
> +               vm_bo->moved =3D true;
> +               list_move(&vm_bo->vm_status, &vm->individual.moved);
> +       }
>         spin_unlock(&vm->individual_lock);
>  }
>
> --
> 2.43.0
>
