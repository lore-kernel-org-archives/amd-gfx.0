Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E404C87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A3710E97E;
	Fri,  8 Aug 2025 19:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJBaADNZ";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C2510E97E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:53:37 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-31f5ed172daso419200a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754682816; x=1755287616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ae4KZUVneHFDA67DPyLOASkj+sJo8pL3Njum1/hKlv8=;
 b=MJBaADNZ1DCaCj4QiWeW+OgzOf75pJm3f9Q3bFYnQ736YxELquMiJxcXkHcBvHwNou
 OZnZmz1gLmwnSKqwJLwP0tIzPBvRjL1cKdnpca4bQWoMJFS0w9gW+dXeKPyQlMTG7+Ls
 kg7dfAwOpyHewLYUOp94dBxHiv2y6hC68cqz1thcyjd+tgbFDdL2NJv+dvTZP8UImuc0
 Ac/qpM2hDQdnKb/tVXpuSLhSs6oNatcHmdxjzpcQ3oBIN+NcrqmPC8zovxrBBMPHolsZ
 z9fF5bwfwuVmC5AN7hsz3IqOlsTOPmVaJkTGFxuPt89VBvACA1xsIkFrHOlMaaaf5B3U
 ZPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754682816; x=1755287616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ae4KZUVneHFDA67DPyLOASkj+sJo8pL3Njum1/hKlv8=;
 b=mnlPPieLivUkrRJRFLuOZOPInFSzoxdoM03UqC6D61/dkzWWdCBwW0SBCssZdM7xIL
 jbUtz5zaKiyArpfuhzG/HDz39MEW1lNV1G5iDgAvtR6yFR7prqf7rgD+8oj8uIcilzGl
 YZEPE1zt8vZ97nj6vkArzA9RGGmy8ozgvRFbaorWAxKv/+tzowrvjNbC8ja0gDXkfjlO
 TX0oeL/pylErCl1u98XbPhNAYj7LkpeWllClFhKQkDByP3Bmev8BlMqXE6AyP90Ya9+Z
 1C6X+cRFqnrPDk4DOAKZEOj4wcc1xVG5WQNi+aatXAuQu8GTKgO1h9m1ukC9V+nyXwPX
 s4pQ==
X-Gm-Message-State: AOJu0YwltXHeWi02UacNvKUVzyOeJF+r08ueJGyL45W1uSpqLOxkaWZp
 xSTCyREhwRWqBnNaSIASPSci4dNx6NUgnNi8bfWcQaI/HgonqpOiA6SrXpUEvdZ+KQ1xIV7+NZN
 ixVkZN0W06WCrSQxRc4daoAr7gKyjI+JSEw==
X-Gm-Gg: ASbGnctvOMV/E7NtAt1FakNh1/5F1VoX87SMj+/XtaXyq7GrMKigE8J4oCCcfPzLwqb
 9oPsoo84KicsJQYAcZmA3x7P5BmcQgcvhHPKrxcFyFfvK7JDwe5TMGraJXeRJionEqMSbqzdPKI
 Dpm0Uzcw4ZatxcN2Kq9FSE+rBedSmUUi6p2y2PWSqRuzsOuUY3yZo2FOdZ24bR59vwDZoom+/Jg
 eO1rX8=
X-Google-Smtp-Source: AGHT+IFN5HK77vyMhjq4RA1IV7RL6rQWRdsLmRuI+Htfjcb44+gyBMcEXq9GgXNQvx+LCej0BY7Xt2N70yMLesq4q4s=
X-Received: by 2002:a17:90b:1b4d:b0:321:3e03:e39f with SMTP id
 98e67ed59e1d1-32197901d82mr155069a91.6.1754682816370; Fri, 08 Aug 2025
 12:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
 <20250806022816.1050823-8-Jesse.Zhang@amd.com>
In-Reply-To: <20250806022816.1050823-8-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 15:53:24 -0400
X-Gm-Features: Ac12FXwIy2c3w0slwI2VlfrRfmnl3UQu5bsOEB2eluXxBnyahQoGZeOFGos_qAM
Message-ID: <CADnq5_OSed17zEQiNHArxFtySCHcp3J2GzEueW3Sf5pSc8UZpg@mail.gmail.com>
Subject: Re: [v7 08/11] drm/amdgpu/userq: add a detect and reset callback
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Tue, Aug 5, 2025 at 10:39=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Add a detect and reset callback and add the implementation
> for mes.  The callback will detect all hung queues of a
> particular ip type (e.g., GFX or compute or SDMA) and
> reset them.
>
> v2: increase reset counter and set fence force completion
> v3: Removed userq_mutex in mes_userq_detect_and_reset since the driver ho=
lds it when calling
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 49 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 5111d7dce86f..9fa0d1a88d71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -81,6 +81,8 @@ struct amdgpu_userq_funcs {
>                    struct amdgpu_usermode_queue *queue);
>         int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
>                    struct amdgpu_usermode_queue *queue);
> +       int (*detect_and_reset)(struct amdgpu_device *adev,
> +                 int queue_type);
>  };
>
>  /* Usermode queues for gfx */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 46b24035e14c..180bd4347bdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -21,6 +21,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include <drm/drm_drv.h>
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
> @@ -198,6 +199,53 @@ static int mes_userq_create_ctx_space(struct amdgpu_=
userq_mgr *uq_mgr,
>         return 0;
>  }
>
> +static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
> +                                     int queue_type)
> +{
> +       int db_array_size =3D amdgpu_mes_get_hung_queue_db_array_size(ade=
v);
> +       struct mes_detect_and_reset_queue_input input;
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_userq_mgr *uqm, *tmp;
> +       unsigned int hung_db_num =3D 0;
> +       int queue_id, r, i;
> +       u32 db_array[4];
> +
> +       if (db_array_size > 4) {
> +               dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
> +                       db_array_size);
> +               return -EINVAL;
> +       }
> +
> +       memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_inpu=
t));
> +
> +       input.queue_type =3D queue_type;
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, f=
alse,
> +                                                   &hung_db_num, db_arra=
y);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r) {
> +               dev_err(adev->dev, "Failed to detect and reset queues, er=
r (%d)\n", r);
> +       } else if (hung_db_num) {
> +               list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list,=
 list) {
> +                       idr_for_each_entry(&uqm->userq_idr, queue, queue_=
id) {
> +                               if (queue->queue_type =3D=3D queue_type) =
{
> +                                       for (i =3D 0; i < hung_db_num; i+=
+) {
> +                                               if (queue->doorbell_index=
 =3D=3D db_array[i]) {
> +                                                       queue->state =3D =
AMDGPU_USERQ_STATE_HUNG;
> +                                                       atomic_inc(&adev-=
>gpu_reset_counter);
> +                                                       amdgpu_userq_fenc=
e_driver_force_completion(queue);

This function doesn't exist yet.  Move that patch up before this one.

Alex

> +                                                       drm_dev_wedged_ev=
ent(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> +                                               }
> +                                       }
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return r;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>                                 struct drm_amdgpu_userq_in *args_in,
>                                 struct amdgpu_usermode_queue *queue)
> @@ -403,4 +451,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .map =3D mes_userq_map,
>         .preempt =3D mes_userq_preempt,
>         .restore =3D mes_userq_restore,
> +       .detect_and_reset =3D mes_userq_detect_and_reset,
>  };
> --
> 2.49.0
>
