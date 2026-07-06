Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13B6C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C1D10EAB8;
	Mon,  6 Jul 2026 20:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jgR7ZAgm";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAB810EAB8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:32:13 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cab31bcc06so2463325ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 13:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369933; cv=none;
 d=google.com; s=arc-20260327;
 b=Ci7UdrLtnqxZKs2c8SxqJkfrO+JtVENAam42Oajk2sQCbs2l7QVQ8ZK6ynK2xOcax3
 FlTbZeiKKf4NwKb1WJItdHgYh2gKBSt0rxapYF8gG62Y4rA79CQ+5OvLZ37ZlhwBN4gT
 gK2R+rbPNCcinTNBs5LTilpRdkz0JF8hd6S/nhDBfZq6jhV5atucFYNJuD/iPvI3vfoQ
 QbnABDA5uwxNv1qcPtWQ4u/RXT4ulQvjQpHQ6igZrsN3fxcbsYzz539toCE98+yfJVHh
 tpe1y3fz4KsWsXnInNe0NVShcmAhNxWExuhZeeZ6Ap1Z7XCCHaAkQfiuT+wdgWvF9Znk
 beww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a4AgdC6wUT2IiNxsWcGZt62ZHkmdGZ8pyWNwSbX7fcI=;
 fh=3qhPNCyN0+nOiDp/zGACa0K0fK1xgTbDko7ztv7ecMo=;
 b=L0Yq9owlISw1CmsCBv77bQtLPTKqqv/BwjuVDm6xUeo2quc9bQT45HVEvjlMWw3dJa
 974fylu2XkT8TAaonYfCoAhGjuww9aG7K5LHkJZvtsJPNc3hfn6r7RqAHa7TynySxPhZ
 Sh22pBBZ4S+CWkswvc0VJlDWd7U3yeqokaGJ+3mDuP/1teGWuWgB26Enb0ir+57rhtvW
 2VOfWr1Dn56dUOJNG8/SvlvSrnvSKGG6hE/B1+bBMX2mXf75E2mPDbMNrXj4cEXJKx2p
 e3CvNOgwDHMHh/Wa9offSPgbXqUfrJKdO0/M7A2qHOWsd0urc+TqPkd0iF8eqYiC5NPV
 VPRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783369933; x=1783974733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a4AgdC6wUT2IiNxsWcGZt62ZHkmdGZ8pyWNwSbX7fcI=;
 b=jgR7ZAgmY06EiqpCLLC9y+pN77ub6kCPk44pFYgCHwGewjWvgy9KL1fP3ovbZ0rSx4
 C6YO/0G7BCPZVwxxuwAZJCFSUsWRu7Pmc/vgGDJb/khV82wG5XxT3+38yyDmxkZgoLTe
 BRFYaAoQN/HIszCxhgaxlCViFCyS6PiP9GIZsOEko+AkeA+bu0Z06nDrgVyBjia0gVUs
 h/+HqnKG0A6HVb9cgCq8v2UGEn+NUQOLszi0K/p3v4ZHJGN9PIR7Arbl9r+t5ViodbBB
 Sxjb6bcEFVd644EsFc7xx1bYEkXkQXRoOj5UJU/iWfP4szPuUwI5TqCtqPUgBafIQNzf
 UrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369933; x=1783974733;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a4AgdC6wUT2IiNxsWcGZt62ZHkmdGZ8pyWNwSbX7fcI=;
 b=lwSNuEVC09031elVaP52sdwfSLfGur2Vt3winRNbvVdU4ZCMlk6hS7iWYn4ONqAEJn
 YaFie46Yl7IXgvyW+5bi2Nx37e0KUYbI3Z/Rzi1kZ01bV2jXJuCs0ykOnqavGyXcbp4/
 jAFNQ4hDbpJtW6KG8fAgRfmzoFHVFfczT8dM5KOcP/L0YBukjjuREOvaV7R00q8atlX/
 Zd7rkPtT4SIDu/6EyOVjzopwEBmlYUWsRZDN45IwgTaJLxWi9eXNH3glU7Zzh6RkePCR
 MoSHQv/NEA3bXBHPYD3cJHnsCMdBpzlC/om2lskFRBXUer+cnsjWuSCE/oT+7dB4AyiB
 Bh7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNt+6NKMDgTml/3I1JRWRb6nJXo3MjvNUnFJTMbHqHIMUIi5AKXv6M7ifLO7iOrgvt1lUihE/v@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd7GqXX6Ow4GcwSAAf34ivvYVo2RKhjkDojGFoyWl8XPziYBRm
 b+pnCTNsgWZrOW/Q8h+V5AivkI2E6tmYrpNDESpDwU88ptnI/HhlkoWKn3OW4HLxwqTJ3/jGBNs
 Cb6/WkIlFv1493x1FpH5gAkVEL1OcqFs=
X-Gm-Gg: AfdE7cm0XqtpLJf08idvfe7cguHAb/bKZMEOmvKe3sWeEs2ukWCTBmkXLQONmz6VzZb
 rpkRnwu97kHW0bWMCptHlvDv0hgtJa5LTelotbCPhDHnwTDO9bVJS+6niHsVqqdfF/6qJRiljPF
 SwdtxqhECfE8g9s5mz2Jrkw4UHjcRix0aX5ekgo8Xk0a5QX3KuNpC5BqMZBzYMlN/CQtZWgyucR
 dj0UQmrHcoD/yRN3/+ZrWGPhfY1C5Q9n0D9r/DIt6vjbs4AaE8W3XjjiQl9kjrhtSkhczUB5NEk
 ClKN3d/TMfigPw72Ibxmp98CAcmZlD/45Z4yghB8Cw3E2s85O5nUBfjlorw=
X-Received: by 2002:a17:902:ea05:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2cb97d1b41emr86269465ad.0.1783369933198; Mon, 06 Jul 2026
 13:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
 <20260611143326.2870571-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260611143326.2870571-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 16:32:01 -0400
X-Gm-Features: AVVi8Cf8-WgVgzs6f__D5TgInyyNZE4tqgaQEKyvanrjvoaX4rzpUXHO5WO6ync
Message-ID: <CADnq5_Ms86rQqsSs9xpzv5G6ZazEQTZmtRnQySqhu2djPj8GEQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/5] drm/amdgpu: Add render-node EVENTFD manager core
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Jun 11, 2026 at 10:44=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Introduce a per-drm_file eventfd manager to support render-node event
> subscriptions.
>
> The manager is implemented in amdgpu_eventfd.[ch] and is owned by the
> drm_file (amdgpu_fpriv). It maps an event identifier to an eventfd_id
> object, where each eventfd_id can have multiple eventfds bound
> (fan-out).
>
> The design is IRQ-safe for signaling: IRQ path takes the xarray lock
> (irqsave) and signals eventfds while still holding the lock.
>
> This patch only adds the core manager.
>
> Duplicate binds are treated as success, allowing userspace to
> re-register subscriptions without errors.
>
> v10: (per Christian)
> - Avoid GFP_ATOMIC in the event identifier insertion path.
> - Use the recommended xarray insertion pattern with memory allocation
>   outside the xarray lock.
> - Simplify the eventfd unbind loop for readability.
>
> v11: (per Christian)
> - Use goto-style cleanup in amdgpu_eventfd_bind() to avoid repeated
>   cleanup paths.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 386 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
>  3 files changed, 447 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index ee3574797bc2..dd5a6fc5cbc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -71,7 +71,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o amdgp=
u_doorbell_mgr.o amdgpu_kms
>         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>         amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu=
_dev_coredump.o \
> -       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu=
_ip.o
> +       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu=
_ip.o \
> +       amdgpu_eventfd.o
>
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_eventfd.c
> new file mode 100644
> index 000000000000..4955ee942a1c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -0,0 +1,386 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + *
> + * This module provides a simple event notification mechanism for render=
-node
> + * clients using Linux eventfd objects.
> + *
> + * Userspace can bind an eventfd to a userspace-defined event_id. When t=
he
> + * driver signals that event_id, all eventfds bound to it are notified.
> + *
> + * This mechanism is intended to support lightweight GPU event notificat=
ions
> + * without polling from userspace.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +#include "amdgpu_eventfd.h"
> +
> +#define AMDGPU_EVENTFD_MAX_BINDS 4096
> +
> +/**
> + * amdgpu_eventfd_id_alloc - allocate an event id container
> + * @event_id: userspace-defined event identifier
> + *
> + * Each event_id represents a notification category. Multiple eventfds c=
an
> + * be bound to the same event_id.
> + *
> + * This function allocates the container which stores the list of eventf=
ds
> + * associated with that event_id.
> + *
> + * Return:
> + * Pointer to the newly allocated structure or NULL on failure.
> + */
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +{
> +       struct amdgpu_eventfd_id *id;
> +
> +       id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +       if (!id)
> +               return NULL;
> +
> +       id->event_id =3D event_id;
> +       INIT_HLIST_HEAD(&id->entries);
> +       id->n_entries =3D 0;
> +       return id;
> +}
> +
> +/**
> + * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + *
> + * This helper returns the container associated with the given event_id.
> + * If it does not exist, it will create one.
> + *
> + * The function is designed to be callable without holding any locks.
> + * Memory allocation is done outside the xarray lock to avoid blocking
> + * inside critical sections.
> + *
> + * Return:
> + * Pointer to the event_id structure or NULL on failure.
> + */
> +static struct amdgpu_eventfd_id *
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 even=
t_id)
> +{
> +       struct amdgpu_eventfd_id *id;
> +       struct amdgpu_eventfd_id *new_id;
> +       XA_STATE(xas, &mgr->ids, event_id);
> +       unsigned long flags;
> +       int r;
> +
> +       xa_lock_irqsave(&mgr->ids, flags);
> +       id =3D xa_load(&mgr->ids, event_id);
> +       xa_unlock_irqrestore(&mgr->ids, flags);
> +       if (id)
> +               return id;
> +
> +       new_id =3D amdgpu_eventfd_id_alloc(event_id);
> +       if (!new_id)
> +               return NULL;
> +
> +       /*
> +        * Allocate xarray memory outside the lock if needed.
> +        * This avoids using GFP_ATOMIC while holding the lock.
> +        */
> +       do {
> +               xas_lock_irqsave(&xas, flags);
> +
> +               id =3D xas_load(&xas);
> +               if (id) {
> +                       xas_unlock_irqrestore(&xas, flags);
> +                       kfree(new_id);
> +                       return id;
> +               }
> +
> +               xas_store(&xas, new_id);
> +               r =3D xas_error(&xas);
> +
> +               xas_unlock_irqrestore(&xas, flags);
> +       } while (xas_nomem(&xas, GFP_KERNEL));
> +
> +       if (r) {
> +               kfree(new_id);
> +               return NULL;
> +       }
> +
> +       return new_id;
> +}
> +
> +/**
> + * amdgpu_eventfd_mgr_init - initialize eventfd manager
> + * @mgr: manager instance
> + *
> + * Each DRM file (amdgpu_fpriv) owns one eventfd manager.
> + *
> + * The manager stores mappings:
> + *
> + *   event_id -> list of eventfds
> + *
> + * The xarray provides efficient lookup of event_id containers.
> + */
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
> +{
> +       xa_init_flags(&mgr->ids, XA_FLAGS_LOCK_IRQ);
> +       atomic_set(&mgr->bind_count, 0);
> +}
> +
> +/**
> + * amdgpu_eventfd_mgr_fini - destroy eventfd manager
> + * @mgr: manager instance
> + *
> + * Frees all registered eventfd bindings.
> + *
> + * The caller is expected to ensure that no IRQ-side signaling can occur
> + * after this function begins. This typically happens during drm_file
> + * teardown.
> + */
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
> +{
> +       unsigned long index;
> +       struct amdgpu_eventfd_id *id;
> +
> +       /*
> +        * Expected teardown ordering: caller ensures no further IRQ-side
> +        * signaling can race with this before fini() is called.
> +        */
> +       xa_lock(&mgr->ids);
> +       xa_for_each(&mgr->ids, index, id) {
> +               struct amdgpu_eventfd_entry *e;
> +               struct hlist_node *tmp;
> +
> +               hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +                       hlist_del(&e->hnode);
> +                       eventfd_ctx_put(e->ctx);
> +                       kfree(e);
> +               }
> +
> +               kfree(id);
> +       }
> +       xa_unlock(&mgr->ids);
> +
> +       xa_destroy(&mgr->ids);
> +}
> +
> +/**
> + * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * @mgr: eventfd manager
> + * @event_id: userspace event identifier
> + * @eventfd: eventfd file descriptor
> + *
> + * This function allows userspace to subscribe to notifications for a
> + * specific event_id.
> + *
> + * Multiple eventfds can be bound to the same event_id.
> + *
> + * Duplicate bindings of the same eventfd are treated as success and do
> + * not create additional entries.
> + *
> + * Return:
> + * 0 on success, negative error code on failure.
> + */
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, in=
t eventfd)
> +{
> +       struct amdgpu_eventfd_id *id;
> +       struct amdgpu_eventfd_entry *e =3D NULL, *it;
> +       struct eventfd_ctx *ctx;
> +       unsigned long flags;
> +       bool dup =3D false;
> +       int r =3D 0; /* duplicate binds are treated as success */
> +
> +       if (!mgr || !event_id || eventfd < 0)
> +               return -EINVAL;
> +
> +       /*
> +        * Enforce total bind limit without a separate manager lock.
> +        * For duplicate binds, we decrement back before returning succes=
s.
> +        */
> +       if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BIND=
S) {
> +               atomic_dec(&mgr->bind_count);
> +               return -ENOSPC;
> +       }
> +
> +       ctx =3D eventfd_ctx_fdget(eventfd);
> +       if (IS_ERR(ctx)) {
> +               atomic_dec(&mgr->bind_count);
> +               return PTR_ERR(ctx);
> +       }
> +
> +       id =3D amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +       if (!id) {
> +               r =3D -ENOMEM;
> +               goto out_put_ctx;
> +       }
> +
> +       /* check for duplicate binding */
> +       xa_lock_irqsave(&mgr->ids, flags);
> +       hlist_for_each_entry(it, &id->entries, hnode) {
> +               if (it->ctx =3D=3D ctx) {
> +                       dup =3D true;
> +                       break;
> +               }
> +       }
> +       xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +       if (dup)
> +               goto out_put_ctx; /* duplicate bind: success */
> +
> +       /* Allocate entry only after ctx/id prerequisites are satisfied. =
*/
> +       e =3D kzalloc(sizeof(*e), GFP_KERNEL);
> +       if (!e) {
> +               r =3D -ENOMEM;
> +               goto out_put_ctx;
> +       }
> +
> +       e->ctx =3D ctx;
> +
> +       /*
> +        * Re-check duplicate under lock to close the race with another b=
ind()
> +        * for the same (event_id, ctx).
> +        */
> +       xa_lock_irqsave(&mgr->ids, flags);
> +       hlist_for_each_entry(it, &id->entries, hnode) {
> +               if (it->ctx =3D=3D ctx) {
> +                       dup =3D true;
> +                       break;
> +               }
> +       }
> +
> +       if (!dup) {
> +               hlist_add_head(&e->hnode, &id->entries);
> +               id->n_entries++;
> +               e =3D NULL; /* consumed */
> +       }
> +       xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +       if (dup)
> +               goto out_free_entry;
> +
> +       return 0;
> +
> +out_free_entry:
> +       kfree(e);
> +out_put_ctx:
> +       eventfd_ctx_put(ctx);
> +       atomic_dec(&mgr->bind_count);
> +
> +       return r;
> +}
> +
> +/**
> + * amdgpu_eventfd_unbind - remove eventfd binding
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + * @eventfd: eventfd file descriptor
> + *
> + * Removes an existing binding between an event_id and an eventfd.
> + *
> + * Return:
> + * 0 if removed, -ENOENT if binding does not exist.
> + */
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, =
int eventfd)
> +{
> +       struct amdgpu_eventfd_id *id;
> +       struct amdgpu_eventfd_entry *e;
> +       struct hlist_node *tmp;
> +       struct eventfd_ctx *ctx;
> +       unsigned long flags;
> +       bool removed =3D false;
> +
> +       if (!mgr || !event_id || eventfd < 0)
> +               return -EINVAL;
> +
> +       ctx =3D eventfd_ctx_fdget(eventfd);
> +       if (IS_ERR(ctx))
> +               return PTR_ERR(ctx);
> +
> +       xa_lock_irqsave(&mgr->ids, flags);
> +
> +       id =3D xa_load(&mgr->ids, event_id);
> +       if (!id)
> +               goto out_unlock;
> +
> +       hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +               if (e->ctx !=3D ctx)
> +                       continue;
> +
> +               hlist_del(&e->hnode);
> +               id->n_entries--;
> +               removed =3D true;
> +
> +               eventfd_ctx_put(e->ctx);
> +               kfree(e);
> +
> +               atomic_dec(&mgr->bind_count);
> +
> +               if (!id->n_entries) {
> +                       __xa_erase(&mgr->ids, event_id);
> +                       kfree(id);
> +               }
> +
> +               break;
> +       }
> +
> +out_unlock:
> +       xa_unlock_irqrestore(&mgr->ids, flags);
> +       eventfd_ctx_put(ctx);
> +
> +       return removed ? 0 : -ENOENT;
> +}
> +
> +/**
> + * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * @mgr: eventfd manager
> + * @event_id: event identifier
> + *
> + * This function is typically called from interrupt context.
> + *
> + * All eventfds registered for the given event_id will be signaled.
> + * Userspace processes waiting on those eventfds will wake up.
> + */
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +{
> +       struct amdgpu_eventfd_id *id;
> +       struct amdgpu_eventfd_entry *e;
> +       unsigned long flags;
> +
> +       if (!mgr || !event_id)
> +               return;
> +
> +       /*
> +        * This can run from IRQ context. Keep the lock while walking the=
 list
> +        * so entries cannot disappear during signaling.
> +        */
> +       xa_lock_irqsave(&mgr->ids, flags);
> +
> +       id =3D xa_load(&mgr->ids, event_id);
> +       if (id) {
> +               hlist_for_each_entry(e, &id->entries, hnode)
> +                       eventfd_signal(e->ctx);
> +       }
> +
> +       xa_unlock_irqrestore(&mgr->ids, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_eventfd.h
> new file mode 100644
> index 000000000000..248afb1f2f14
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + */
> +
> +#ifndef __AMDGPU_EVENTFD_H__
> +#define __AMDGPU_EVENTFD_H__
> +
> +#include <linux/eventfd.h>
> +#include <linux/xarray.h>
> +#include <linux/atomic.h>
> +
> +struct amdgpu_eventfd_entry {
> +       struct eventfd_ctx *ctx;
> +       struct hlist_node hnode;
> +};
> +
> +struct amdgpu_eventfd_id {
> +       u32 event_id;
> +       struct hlist_head entries;
> +       u32 n_entries;
> +};
> +
> +struct amdgpu_eventfd_mgr {
> +       struct xarray ids;          /* event_id -> struct amdgpu_eventfd_=
id* */
> +       atomic_t bind_count;        /* total binds across all event_ids *=
/
> +};
> +
> +void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
> +void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
> +
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, in=
t eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, =
int eventfd);
> +
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)=
;
> +
> +#endif /* __AMDGPU_EVENTFD_H__ */
> --
> 2.34.1
>
