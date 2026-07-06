Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0ADC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4888D10EAC0;
	Mon,  6 Jul 2026 20:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lvss/4oE";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5423610EAC2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:32:28 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2caa0551d8bso10632365ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 13:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369948; cv=none;
 d=google.com; s=arc-20260327;
 b=eVWfEaseMpLEAc7BdHPNuCZ5bIMSO0LP8bmlflVrhoOZaPiPecl+s/hhJL0uZQz8j5
 ffeJHxvq+QJjK/r3Ws2Ao1JR2mwAoegYvPes+0jZwovrAeXVNzmpuTXM7hu9i4pwxv1T
 lVPzOzH4qAD6m1IEdrL/lPkZ947/qqEZ0ntUBYNT3dZXBfhfw3IlkPo0thJkugCrP2M3
 t4YTd1IeJrTX/HpzXPp3q1QTJvt05U+cnW9NaHTB/8A9fXyjRxnjBm3pxUAvK7I0/QvK
 W4EZJVKJY1Bg/Xq9LkiYg66xcvWl6JxmIy5NBCDPxrF3ogIKWcHH6+ydSs2O6BKXbue0
 Ynyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AlZe0SHNxO/CLsm+kOy6ux97+SRS1T2/g5JQftypR7c=;
 fh=C4VfhFjGNUuS0cd2a5CLewJc4TpGH33c1kC4GacUGqw=;
 b=eM5RtApvIJCeJH2+wjMtscKS3kjfQMI/S/Ujm1xNLkNkXUE7QOsq6DVMbKAv0agQjb
 vRHubfgDiqW8wZ+0CAMRf8l0POUQAPgy+yQtLKCgOLsL6//4G5i/y6RFBs9ydE8+vHgM
 T1OtsFgwrLbHiq34W+unLnBGzTlO3jUSXq9qKTjd/tuI2i7tnnKo6n2TiR9FXHdy2JMs
 5IqDsWrVt6nNKNrpMNpG5eMEIDoLQXJfJKXEovIlQLIbjOZR/Gyv+zytwTMED9qSrq2P
 4Vsd3wJDhgw9hWmMLfSU0qN+w8fsuQ+bN0m4feJhywUeRiRkzy7y9fzZvloP3zdekxoM
 Qlkw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783369948; x=1783974748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AlZe0SHNxO/CLsm+kOy6ux97+SRS1T2/g5JQftypR7c=;
 b=Lvss/4oEX1dRAsEzPXYoU+zzTKeZULa/zZz45yD1ti5Nkedzc3JbieTupdJO/M/n50
 krJ5VheO0x88v16sOELBZT3NBqIF0g34/tfP+FnsVZsPaX3Mnuqy9A6oy1fKmrmfjQm9
 IXt9JJw4YiEzT/9SK1EPkB7Qs3HzW65Roy8wyJIGPL6VR5fTygrkQfHUpM01OSg5Yv9H
 nQKNWJ81097vIRODxUJUV8qxyZXcqp+7aOAkO070kGR7nWP4iiG/fsUx33JARHkpGLOw
 /hbls7OCmyrEN8vK/WyX9RfuFF6Y2KQNSWiQR6+PlJALvAaTU3QsCPTmQvrjeTyDh15c
 8G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369948; x=1783974748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AlZe0SHNxO/CLsm+kOy6ux97+SRS1T2/g5JQftypR7c=;
 b=Rnotmd+iYOWslFNt02mclyT0wimtlV75Hb3MuvIAdgpxREeVtzwuv4BOdOtGnDdtJw
 s9qu6Ijz1OzUZSudHjbiAk47Zz/tbudksm6eAzEqH5xAGNLaEGLRaRS6T5bpVdSHrNJb
 me+CmogGWrLKSXGjhk8uY9XKMuetrLF0/kTyt2RyTGOZkEs4lSmHa61UdKtmfCtHliS1
 IZTIeBwT0rp6/rhbSVuieSr7FaTqLs0T8FnTteWwmDRCkJ8AlNlHXlX/K9xZbTJ5G6mB
 I723gLVVCbjfpnJLkRwlSGcUpBhKQ5DQJ8XwkmX/yw1+0we6UUE5Z5u3+RYca7WpKgVq
 UbdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEVGo1G3bvTrbuBccakuxMSi5dfsApMKUg1YO9SOxa1EUNIlUKZt+/9vFyJjl4PXUMca4zzZCN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiYOWfZkwIW4y0+D0H4d33Y4aV9Ve0VI/AZ9pe6ZugQlOuEVo2
 gO7+vN9tbYXlTx7sdkXleXx5y1mH1LTSVLz3FJJIiBvXP2zH6JAlvyitQewCS8+Q8Wg9R0jWviX
 fwQ1TFxD7ZLxCKd6mmAplgS8yl3H1F0A=
X-Gm-Gg: AfdE7cmnMKhdO7TgvmZBpGO0w6JaW9STypsA7GIC2OGJ9YdBk1JjvNtSTcRStvOtVvR
 lWRcL5VLm+3jfO94MhLPyrD+7P+dMY3BkXgTRuPZ7+1tJMf3gX4TMBReQRdflpR50Wj/hLPuI3q
 pE0jBwvmOHM6UhAmBU81Vsji3A91LN6EqhjZ3KbwHm24eQdp+ERcq/pfKxR7t0St/vb463Y0um7
 QEunEm6vgeESpLcAj46Qb9rDL/7g6VOLPArvrlKBS60rMaxNlk6JcTvz8Jq34MsgF+cyF9uYpoP
 DcqK/Umy3NVDqQJDiOcB6BCr1Xc9YxnOzvyOV/tStuVwra8pozMQczzPEXQOPLk3DVuH+Q==
X-Received: by 2002:a17:902:cf0d:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2cbb9ebba2emr70111285ad.4.1783369947840; Mon, 06 Jul 2026
 13:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
 <20260611143326.2870571-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260611143326.2870571-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 16:32:15 -0400
X-Gm-Features: AVVi8CfC2n8NVoyBC5tgz25_eshAaUKxu3MXJSYn4RdtdcbHiFm2P-yy0-rcg60
Message-ID: <CADnq5_NoH2_LRQVQBqV4WcK7i05JM3qgnk9GdegNhe5pF6Fa-Q@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
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

On Thu, Jun 11, 2026 at 10:59=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
> by embedding the manager instead of storing a pointer.
>
> This removes the need for reference counting and avoids destroying the
> manager from IRQ context
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5d7bfa59424a..a75c68195df9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -104,6 +104,7 @@
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_mca.h"
>  #include "amdgpu_aca.h"
> +#include "amdgpu_eventfd.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_cper.h"
>  #include "amdgpu_xcp.h"
> @@ -455,6 +456,8 @@ struct amdgpu_fpriv {
>
>         /** GPU partition selection */
>         uint32_t                xcp_id;
> +
> +       struct amdgpu_eventfd_mgr       eventfd_mgr;
>  };
>
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)=
;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..f5719500527f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1460,6 +1460,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
>                 goto out_suspend;
>         }
>
> +       amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
> +
>         pasid =3D amdgpu_pasid_alloc(16);
>         if (pasid < 0) {
>                 dev_warn(adev->dev, "No more PASIDs available!");
> @@ -1556,6 +1558,9 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>         if (!fpriv)
>                 return;
>
> +       /* Drop all subscriptions before fpriv goes away. */
> +       amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
> +
>         pm_runtime_get_sync(dev->dev);
>
>         if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) !=
=3D NULL)
> --
> 2.34.1
>
