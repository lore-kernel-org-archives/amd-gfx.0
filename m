Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C3EE909CF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B1D10E50B;
	Tue, 17 Feb 2026 16:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b0FfDJ30";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C7D10E50E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:21:36 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1275750cfadso35938c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:21:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771345296; cv=none;
 d=google.com; s=arc-20240605;
 b=L1r0mF5zqZ0xQX+YUFfHZd51csPGaEzSp9cbh0V8A0DmyBMGH82gOQWi5hJ9PcG4G1
 J7XQMKS38UuSjJ8FnWweVcxVx5GIbGJ9HzAvDwrEIk6AqQ9+HGpcoNa+ZohvdLPr3ssT
 Ct/ULpfjVKhhvnAEX9uJf/Du6tU6j2wkNL6BkzUyrz0GNytVpk4iBhcmKw5vG8nUBUGq
 b1N5ziHoHcP8E3JeRSkeJuCt8fZ2P4bUIVhzAX2MQ3j72eQkTuNibhXcGmXzwV5pnKvk
 9tZ1nY4mzQPX7JJjNZFG9Hg4M88NKPAcbqo+rDSxvIRqnmvETRGHH+v0rUg9zi9n6kv2
 rfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5OjLMNpEhGZOhH95nEM9Q612OzOTY/1NripapqhTwW8=;
 fh=urzI87u1YYNEF/EfWkJOigkPKEHze3jtz8WcTjGuDbE=;
 b=Qgpd1jofpcJdlvrBrKeXEsx7ofS68e2U/hOL7YdPpdC1Dd+dzVN1eiKiDlDO69Jszc
 DI4ra4aMx/6AVR4kPxiY0VD23Lp6o4mD+lG+Ay3UO9qEuVSkZByutM+xSlYgwJTFNu4m
 wzJfzGEF9V+sgu6fWeh/VsrsGxuGX8kDc+pnPYRXurKoSnCfhoTcNKGld7msJK+i7oeF
 hHZ0krTLOACYi+WfTNlM2mXVqAr/2nC45KV94zRN4YG/C4lYUsthGTAF01El6G7xcsAm
 SHcsXrUEzmGirqPVyh2LH0pNG3I9bbH6Z7ZoRPiuisx0CypxKKtoNYCfuvJ1Krqd/P+d
 phLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771345296; x=1771950096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OjLMNpEhGZOhH95nEM9Q612OzOTY/1NripapqhTwW8=;
 b=b0FfDJ30pCzvZwQQCGtIzsLGrCqIFsNrUgjsq2ehyOxMuzfF3wEn/wrtdDX+BGlRSu
 MfEbDmJiVwOM9HNlsyt9Sfd7hSwYtgNJrHuiKTjgvgvGbDskW/K1dnRyxjib451u6RrD
 qPvarLMRr+Cvy9ix50Y7mpplZBtIBZupOx30DsYU7hpsOQ4/xPSQkfpLZi5BbbJq97RW
 5RHoB64wmVaCrXjWjqiW2Jpq85/htuG7NPOwCjTW+SW1PXhsSVnId4F3moOPMq4Pgejp
 QGufmG/qkTtkQsY9IfOWUvZCg6BZcgpZkQi1JZgWZQwPU9d7i3pF7cOdcU27bNbqCRld
 nVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771345296; x=1771950096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5OjLMNpEhGZOhH95nEM9Q612OzOTY/1NripapqhTwW8=;
 b=LhCllbCR60hY5bk3MpymKnr5A8t5twxmQtHVVZAhk6y2S5HNgG25OvnNtxPjdJB4Na
 sME8ZCpEXmm3riOdQu2uah/ew5Zf0hLOSsisQ0izvb5wOAbPveEEdgZhZ/5UFYhP5B/v
 pU+ZhKG2WxkkKU5Dnu2qpw+2lK1wO/BwNlwsrYJH1Jd1yURMDgJrSnmT8BJYNC10NL02
 KnGsqbfGdDe33uQ3eVyaXZtb3qksikGpAg/uCIxVo4kfz/lT/Pc8bCYmUIqV0JCsDgJB
 hxhYr+olckdct9Nbx53F2WGkH7QmQy1FXCcIpE9ZELCwRXo9zQlSTw7kooae7hwauHfM
 49rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWroBaPoUKb7uOmJ9b23LX1M5K8gh2Ww0XL6qSH+2GQ/huCqIJ6k6bGGK7ZSimPzDKnOvZ5t40@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT+jfGl1FNYFLtmXfPd/BaD8yP2yrzrq20e7DklxhhLRebA8al
 Ebpvms86EZ4bB+jlTsFqgaMwjoGWLR0xjk800CPDSOGBWHpxIePjrLbcVj9W7AUQkQwzMXVZs9w
 j3GhHF4jDuYsiEKniUz8U6SodkT0dOhE=
X-Gm-Gg: AZuq6aIYNRoxSLZgi87BLCp0r3vjFFuLTsyaoRCULg24GemrGKeCOH9vm1XV/EEb4+o
 eIqPhNgjMxm+rsn+2IOV9cLVrmQi+1Pro4ZJcDIdhkckqY9bZfrwQws6ZWFa+THWjeELTxpBH4m
 rKAWyqTkoBNeLvsalcqtSSvyA41lT97U7C6jDB9UgLICYbjVFvKlvVT/Sz5wuZpvjWTimGzpQpu
 DtrQmSi9kKBOxRBzGzJ/uTSHg0ZD+EEBU8VBOWS/egz512mZbl4bcnGhZ4nhpBwl2ME1kCYr892
 2kjmbCewgp78Q+dnDsOg2+E17+V+pPez6MS/YYf5cEM+JY+I9ILSCdHZ59C3TER/8uiWYQ==
X-Received: by 2002:a05:7022:6b98:b0:123:308f:667b with SMTP id
 a92af1059eb24-12739793cc8mr4162045c88.2.1771345295795; Tue, 17 Feb 2026
 08:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-4-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-4-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:21:23 -0500
X-Gm-Features: AaiRm50OCgHm5iw9B2jU8EV7pEsKwcUfBQT0WA1EEpOMEpk41fegxP0li_OlOuc
Message-ID: <CADnq5_OS1k3EdY73hw+68nHC2Qg8KcjX9bLYZKp-R6df1vLUow@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/amdgpu: extract amdgpu_vm_lock_by_pasid from
 amdgpu_vm_handle_fault
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 11, 2026 at 5:37=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> This is tricky to implement right and we're going to need
> it from the devcoredump.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 84 +++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  3 +
>  2 files changed, 57 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 807f8bcc7de5..6a5b3e148554 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2930,6 +2930,50 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
>         return 0;
>  }
>
> +/**
> + * amdgpu_vm_lock_by_pasid - return an amdgpu_vm and its root bo from a =
pasid, if possible.
> + * @adev: amdgpu device pointer
> + * @root: root BO of the VM
> + * @pasid: PASID of the VM
> + * The caller needs to unreserve and unref the root bo on success.
> + */
> +struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
> +                                         struct amdgpu_bo **root, u32 pa=
sid)
> +{
> +       unsigned long irqflags;
> +       struct amdgpu_vm *vm;
> +       int r;
> +
> +       xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +       vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> +       *root =3D vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
> +       xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +
> +       if (!*root)
> +               return NULL;
> +
> +       r =3D amdgpu_bo_reserve(*root, true);
> +       if (r)
> +               goto error_unref;
> +
> +       /* Double check that the VM still exists */
> +       xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +       vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> +       if (vm && vm->root.bo !=3D *root)
> +               vm =3D NULL;
> +       xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +       if (!vm)
> +               goto error_unlock;
> +
> +       return vm;
> +error_unlock:
> +       amdgpu_bo_unreserve(*root);
> +
> +error_unref:
> +       amdgpu_bo_unref(root);
> +       return NULL;
> +}
> +
>  /**
>   * amdgpu_vm_handle_fault - graceful handling of VM faults.
>   * @adev: amdgpu device pointer
> @@ -2945,50 +2989,31 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>   * shouldn't be reported any more.
>   */
>  bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -                           u32 vmid, u32 node_id, uint64_t addr, uint64_=
t ts,
> -                           bool write_fault)
> +                           u32 vmid, u32 node_id, uint64_t addr,
> +                           uint64_t ts, bool write_fault)
>  {
>         bool is_compute_context =3D false;
>         struct amdgpu_bo *root;
> -       unsigned long irqflags;
>         uint64_t value, flags;
>         struct amdgpu_vm *vm;
>         int r;
>
> -       xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -       vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> -       if (vm) {
> -               root =3D amdgpu_bo_ref(vm->root.bo);
> -               is_compute_context =3D vm->is_compute_context;
> -       } else {
> -               root =3D NULL;
> -       }
> -       xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> -
> -       if (!root)
> +       vm =3D amdgpu_vm_lock_by_pasid(adev, &root, pasid);
> +       if (!vm)
>                 return false;
>
> +       is_compute_context =3D vm->is_compute_context;
> +
>         addr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> -       if (is_compute_context && !svm_range_restore_pages(adev, pasid, v=
mid,
> -           node_id, addr, ts, write_fault)) {
> +       if (is_compute_context &&
> +               !svm_range_restore_pages(adev, pasid, vmid, node_id, addr=
,
> +                                       ts, write_fault)) {
> +               amdgpu_bo_unreserve(root);
>                 amdgpu_bo_unref(&root);
>                 return true;
>         }
>
> -       r =3D amdgpu_bo_reserve(root, true);
> -       if (r)
> -               goto error_unref;
> -
> -       /* Double check that the VM still exists */
> -       xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -       vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> -       if (vm && vm->root.bo !=3D root)
> -               vm =3D NULL;
> -       xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> -       if (!vm)
> -               goto error_unlock;
> -
>         flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
>                 AMDGPU_PTE_SYSTEM;
>
> @@ -3027,7 +3052,6 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *a=
dev, u32 pasid,
>         if (r < 0)
>                 dev_err(adev->dev, "Can't handle page fault (%d)\n", r);
>
> -error_unref:
>         amdgpu_bo_unref(&root);
>
>         return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 139642eacdd0..2051eda55c99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -589,6 +589,9 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *ade=
v, u32 pasid,
>                             u32 vmid, u32 node_id, uint64_t addr, uint64_=
t ts,
>                             bool write_fault);
>
> +struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
> +                                         struct amdgpu_bo **root, u32 pa=
sid);
> +
>  void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>
>  void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
> --
> 2.43.0
>
