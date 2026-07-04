Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3128BC43458
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2026 11:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2912210E063;
	Sat,  4 Jul 2026 11:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZptEJEt";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F5310E063
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2026 11:32:35 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so1209664a34.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Jul 2026 04:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783164754; cv=none;
 d=google.com; s=arc-20260327;
 b=pKLT73JbxGzD34L+7p1oe6f4uQNC6CL/Ak8jyA8bcGSOHv2pPrGicHFuFBP2kU39Ox
 qWlL57NEXR0VE88/qFKRSPDLH/yZ0w+A81XZ07cKL9UQx33jZkSmlE3PDf8/yRIhpzXC
 bj3ZcqzUsvzxKBrxtK9t3ESNiL+kYaM4vT1mUAJj1HFNtoZxayWNtBs79YbV5JnvoCH0
 XjHphFjgtJLHb2mM+OKX02OYzVolxyueSZlpdRor1Vwlut1gf4pyhNIvDnrjElMQeqtA
 dOHtcY4Pyo7DPH49w08GZrdUIubiAkdH/OjIflN74kDJLwgLwxFbpOroAcOEBDtZ+7bB
 kO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EWxbVxt0bUrbMOVyYOzNg2L9Hi49TedpZAPD1zNG07k=;
 fh=SJrMnRkxp8IQkIbiKOUW3HLQIzmrYPNSiXSbnrjdcUA=;
 b=dp/v2Wwv59onM+enxBBAo/Wk/XCiPNZRW4mizLXh+6MFz0JeQGmCfht/QfkUj5iL2T
 1fIT8TEePF20q4AqvpxlCHme4minXrwaihnNlY6nWLYsnaGgrcOjoRSDWw9PFyFJExKN
 0fwxIIj+z9CJch3FBBkdxzRwHToi7u8/sB5z3fBkWiHNxL/1ZUnT9HgQ1/H2+cLo/qtF
 aKRaHU8pe2N7Fec0meZPLToS59zfs2bw5EIz3lnHHbVdKrVXnf6u61GcDRqcF/l7Pw2g
 WuzQSkkAyhuAg/I5RWEOY/ond4SqZ4KLf13us4wQcYatAEJzyII4bQ09VY2PubnAg1rb
 1gAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783164754; x=1783769554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EWxbVxt0bUrbMOVyYOzNg2L9Hi49TedpZAPD1zNG07k=;
 b=nZptEJEtjI4Rozy82GimeG8VlLPXyNWrLTOBL8X9XF/19WloZKBZFELr4dA2RT/u13
 gkorxCGho7x++GXwzTaQQvx6zIxY5Jz7r24mb93fU8lUQ9skTCxchCpdudZm4rj91Mr5
 tF/IOpem/yiPOo7f+cLswbwkRrmnV7YEKTazcBCsRYKixhAlSMtdXVXV8opE64APxNaJ
 Qgp1xJvZdOzc6PIV9pnhaXdMEawzPpP+wch7TLYeo7ud3M0xIFlGpdzRveW5XiRqxsEj
 UHazDjo11TKp7JNNPTg0xwDzVlRV65zK01ugyC6RHuaDDJj6tDmB+/m151o/DnfgKl+f
 yRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783164754; x=1783769554;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EWxbVxt0bUrbMOVyYOzNg2L9Hi49TedpZAPD1zNG07k=;
 b=KbOSdQRvzhCbrqQY6LkOaE14n0eNLUretM312JjOVwTzgLDuEf17zesrx1V7urI48v
 culxOHVG+ulaMX/nu4ci5pRNHleIz2Qe9Xi16MkxbGCQeMdeBCtlSsHMrABu+5uyu7OA
 0sYetFcxm3vsUKLYdkBVkDxlGy0orMoSZHBrqnOFXKowWUF546le/zNNGvVLKGGDiuxn
 9JW4kVykEsJBsQH8o5GKxBCW2qtFYARgZsoOC0ff2SRVjb+v3oDy6G9hWHrb4OyMsUJ5
 oSwg+dm2AHvasKD8oU2Dn8ZsZkaft/12fhtkT0OPkFs5qIqLugAS5iYhsbU1gl11p08S
 43Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ+65a3BorZ61PA5akroamVA0ZtDoQSGfWyZyUHRkPk/+D3PAjkcb6nsFVS07UEkJLkzn+aDtJM6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywl0qFoqQ+1IS541btHhu2Y8qtGKg2F6GBgYf2EynET1gxkz+4C
 HUZM1jeEq06MzZj8ppjcYNfPA4lZTZPwQ0+RPnF5MVHOESLrdn8mnFgbyeghHlX+e59J1O13NuK
 z4yoqvY/O98BXeYVTJIqYrjOigI1TzKA=
X-Gm-Gg: AfdE7cmVeTS2NgWf9mBdenu5r41AwcX7Yg+zZNtHQA3o7l/lak0TkNinzFtcG8OoFou
 Ou93cO6Zl1fjgw7hq0NQFyF7Qyj+wq2SnhcPsdJR30bTw8zrf6UJ4Tu632SZPTNrw5C/bSznsIw
 MYVO+OvMjzmiRrvvVjN2iMXGEP1iG7oS+ioUFkkn+spMP+3RR5C5d2REFYEbOMMLFLH6SrLlbVg
 r2WWpbr88ubm5zSlfFi4fOiIlsgKvp5zg7IQkS5YOE3E97lgR/mdIklMfG+IBKdGXIbutRnp3M=
X-Received: by 2002:a05:6830:258e:b0:7e6:f2dd:93c3 with SMTP id
 46e09a7af769-7eb7ff1bee0mr1941047a34.15.1783164754180; Sat, 04 Jul 2026
 04:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260704084133.122053-1-christian.koenig@amd.com>
In-Reply-To: <20260704084133.122053-1-christian.koenig@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 4 Jul 2026 16:32:22 +0500
X-Gm-Features: AVVi8CcK_S66JOwlm4n0LTy0xr_IGeFKHbpsM77Kmo3cE5f0eLtGIWRvXB6zhGs
Message-ID: <CABXGCsPB4V6h-vUHwQ0Fo=bsdn66xP4fOOOezwWw2hiKh5TRJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_exec: avoid indirect goto
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 peterz@infradead.org, jpoimboe@kernel.org, llvm@lists.linux.dev, 
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Sat, Jul 4, 2026 at 1:41=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The drm_exec component uses a variable with scope limited to the for() an=
d
> an indirect goto to allow instantiating multiple macros in the same
> function.
>
> This unfortunately doesn't work well with certain compilers when the
> indirect goto can't be lowered to a direct jump.
>
> Switch the indirect goto to a direct goto, the drawback is that we now
> can't use the dma_exec_until_all_locked() macro in the same function
> multiple times.
>
> The is currently only one user of this and only as a hacky workaround
> which is about to be removed.
>
> So document that the __label__ statement should be used when the macro is
> used multiple times and fix the tests and the only use case where that is
> necessary.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  2 ++
>  drivers/gpu/drm/tests/drm_exec_test.c  | 24 ++++++++++++------
>  include/drm/drm_exec.h                 | 34 ++++++++++++++------------
>  3 files changed, 36 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index fee4c94c2585..fc28d0fdad37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3011,6 +3011,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *a=
dev, u32 pasid,
>         is_compute_context =3D vm->is_compute_context;
>
>         if (is_compute_context) {
> +               __label__ drm_exec_retry;
> +
>                 /* Release the root PD lock since svm_range_restore_pages
>                  * might try to take it.
>                  * TODO: rework svm_range_restore_pages so that this isn'=
t
> diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/test=
s/drm_exec_test.c
> index 2fc47f3b463b..7a374e462348 100644
> --- a/drivers/gpu/drm/tests/drm_exec_test.c
> +++ b/drivers/gpu/drm/tests/drm_exec_test.c
> @@ -180,19 +180,27 @@ static void test_multiple_loops(struct kunit *test)
>  {
>         struct drm_exec exec;
>
> -       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> -       drm_exec_until_all_locked(&exec)
>         {
> -               break;
> +               __label__ drm_exec_retry;
> +
> +               drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +               drm_exec_until_all_locked(&exec)
> +               {
> +                       break;
> +               }
> +               drm_exec_fini(&exec);
>         }
> -       drm_exec_fini(&exec);
>
> -       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> -       drm_exec_until_all_locked(&exec)
>         {
> -               break;
> +               __label__ drm_exec_retry;
> +
> +               drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +               drm_exec_until_all_locked(&exec)
> +               {
> +                       break;
> +               }
> +               drm_exec_fini(&exec);
>         }
> -       drm_exec_fini(&exec);
>         KUNIT_SUCCEED(test);
>  }
>
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index 8725ba92ff91..cc2937185a9f 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -101,17 +101,6 @@ drm_exec_obj(struct drm_exec *exec, unsigned long in=
dex)
>  #define drm_exec_for_each_locked_object_reverse(exec, obj)             \
>         __drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(=
drm_exec))
>
> -/*
> - * Helper to drm_exec_until_all_locked(). Don't use directly.
> - *
> - * Since labels can't be defined local to the loop's body we use a jump =
pointer
> - * to make sure that the retry is only used from within the loop's body.
> - */
> -#define __drm_exec_until_all_locked(exec, _label)                       =
\
> -_label:                                                                 =
        \
> -       for (void *const __maybe_unused __drm_exec_retry_ptr =3D &&_label=
; \
> -            drm_exec_cleanup(exec);)
> -
>  /**
>   * drm_exec_until_all_locked - loop until all GEM objects are locked
>   * @exec: drm_exec object
> @@ -119,9 +108,18 @@ _label:                                             =
                        \
>   * Core functionality of the drm_exec object. Loops until all GEM object=
s are
>   * locked and no more contention exists. At the beginning of the loop it=
 is
>   * guaranteed that no GEM object is locked.
> + *
> + * A global label name drm_exec_retry is used, if you need to use more t=
han one
> + * instance of this macro in the same function the label needs to be mad=
e local
> + * to the block with the __label__ keyword.
>   */
>  #define drm_exec_until_all_locked(exec)                                 =
       \
> -       __drm_exec_until_all_locked(exec, __UNIQUE_ID(drm_exec))
> +       for (bool const __maybe_unused __drm_exec_loop =3D false;        =
 \
> +            drm_exec_cleanup(exec);)                                   \
> +               if (false) {                                            \
> +drm_exec_retry: __maybe_unused;                                         =
       \
> +                       continue;                                       \
> +               } else
>
>  /**
>   * drm_exec_retry_on_contention - restart the loop to grap all locks
> @@ -129,12 +127,14 @@ _label:                                            =
                        \
>   *
>   * Control flow helper to continue when a contention was detected and we=
 need to
>   * clean up and re-start the loop to prepare all GEM objects.
> + * The __drm_exec_loop check exists to prevent usage outside of an
> + * drm_exec_until_all_locked() loop.
>   */
>  #define drm_exec_retry_on_contention(exec)                     \
>         do {                                                    \
>                 if (unlikely(drm_exec_is_contended(exec)))      \
> -                       goto *__drm_exec_retry_ptr;             \
> -       } while (0)
> +                       goto drm_exec_retry;                    \
> +       } while (__drm_exec_loop)
>
>  /**
>   * drm_exec_is_contended - check for contention
> @@ -154,12 +154,14 @@ static inline bool drm_exec_is_contended(struct drm=
_exec *exec)
>   *
>   * Unconditionally retry the loop to lock all objects. For consistency,
>   * the exec object needs to be newly initialized.
> + * The __drm_exec_loop check exists to prevent usage outside of an
> + * drm_exec_until_all_locked() loop.
>   */
>  #define drm_exec_retry(_exec)                                  \
>         do {                                                    \
>                 WARN_ON((_exec)->contended !=3D DRM_EXEC_DUMMY);  \
> -               goto *__drm_exec_retry_ptr;                     \
> -       } while (0)
> +               goto drm_exec_retry;                            \
> +       } while (__drm_exec_loop)
>
>  /**
>   * drm_exec_ticket - return the ww_acquire_ctx for this exec context
> --
> 2.43.0
>

Tested on the configs that originally tripped objtool, the error is gone
with this patch:

  - gcc, non-LTO: amdgpu_vm.o builds clean
    (was amdgpu_vm_handle_fault+0x169 / +0x97)
  - clang, non-LTO: amdgpu_vm.o builds clean
    (was amdgpu_vm_handle_fault+0x12d)
  - clang + ThinLTO + KASAN, OBJTOOL_WERROR=3Dy: full vmlinux.o link
    passes objtool (was amdgpu_vm_handle_fault+0x186 / +0x16b)

x86_64, clang 22.1.8.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

FWIW the kernel test robot reported this many times across trees (clang
LTO, clang non-LTO, and gcc builds); it's all the same drm_exec
computed-goto pattern. Full list if you want to add Reported-by/Closes:

Fixes: 9920249a5288 ("drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to
drm_exec")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606231854.7LeCtlLe-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202606232356.gwHMAJAW-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202606240753.kYjobJVl-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202606241110.iUga5vVw-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202607031446.1PWG18mN-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202607031837.HSmBj8pr-lkp@int=
el.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202607040159.GopyEswS-lkp@int=
el.com/

--=20
Best Regards,
Mike Gavrilov.
