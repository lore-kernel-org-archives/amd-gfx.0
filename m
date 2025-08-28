Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5E7CA0FF6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 20:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DB210EAC3;
	Thu, 28 Aug 2025 20:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GDojbDho";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6804D10EAC3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 20:45:17 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-327e1b55324so2335a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756413917; x=1757018717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZF32vFq0atX/zocGmwIjvUoHmcldgLFwmB8LVXD/hQ=;
 b=GDojbDhoQdW9bEVG4fF55D3ljSjOoFh1Rfvvq77BfX3zDGX5mmT5oom6dNpfN7Wr52
 lHowKQO49di6bjXkt9/Y+2wNjxGcl2q7gAAzyALuBHFGzTgFJBmGxBlrTL+/sQkw05G3
 cCq6DoqeFdfTqQpRAu7+zKqg00YZb142iZgA5+5qFlVb0htNp2aMrxsdKn6PCuBAsKTs
 6N2OApmcTFww15Q8mw7bWuaybEBPpuc5AyXnK/qGYM4hEWKyHdR8W5EScOPFegp6fTk+
 OtNhJ32cHoQvUXePpdI+GonsO/J/ItAce0vu+wxqSOVP4zIwU38i1k5vF336XZrNhEO7
 HUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756413917; x=1757018717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZF32vFq0atX/zocGmwIjvUoHmcldgLFwmB8LVXD/hQ=;
 b=e8m5otLp6EK/C3jBdmLcwfABO3+9aRePLBSdokkZFvTwYa5w6MkU9dbHQzfGlbTSnj
 2bmli2vjhEBneRZF3MBJztIW/Sn2FLddfZOioWvsH14kceDryd5R4SZeEMmzPD8y6EID
 hnPsEOOb2kVwWkXjfnFgjWEQjoRrjGXfZJlPH4NoLzzozip/0ounXcZrU6japCSLqCO4
 F1pPTWtfO1pDW5EaB+XvBodo0+K3bnUsMKMAadDD92R6D28eKqpM2end1OIfSsx+iopP
 DEu/0l3Zf1GK/oW/tC7JbMzQip7clgiV+SPtj9GYGaR7nvKf0VqheIE27Tkm5Jb3z+Ud
 2iHg==
X-Gm-Message-State: AOJu0YylqF27RuiBmwJLDMiJteZAgcxC6ly+FIZebd8KkpjOe6HahFls
 fYR+bcB6Y+cfTe10UadbCz/YtYJaYqXdslI9BaMPV3XOJ69MMFPjSlLOXqY+zxBp0RWLD7L4oBa
 wqX82xNFpcJ4Yw83rxgbnPE296HrSikM=
X-Gm-Gg: ASbGnculL5Dxk/xMHNGbC41n8m51MWaIYkc41DBCpP09k45NEjVzVvKuzAmo5f4NBG+
 QRGtj77arnl+7FDWlDyKxjYRBjxJg0kujmjNFKB5KOCOGijPusEMOY+xpG6ns7QDsuaeSJXCRjg
 PvuOPCXrdBm6f5MHnEiTLdowE89yM+s4apoxK92MstlMdtMB0czzGzLqg9XmLAglLLCtLIloZt0
 1snOYx/tQOTHfTOAQ==
X-Google-Smtp-Source: AGHT+IFELkgLrOA1s7Unbag7aGqYB37kTGFlAmpzurBO67eXb++JQnlY7lh5A06v4QQxIF3apBaow1y8YDIs43vQ/P8=
X-Received: by 2002:a17:90b:4f45:b0:31e:ffd4:ecdc with SMTP id
 98e67ed59e1d1-32515ef2adcmr15390415a91.7.1756413916815; Thu, 28 Aug 2025
 13:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
 <20250828084457.1999535-9-Jesse.Zhang@amd.com>
In-Reply-To: <20250828084457.1999535-9-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 16:45:05 -0400
X-Gm-Features: Ac12FXwzLMdVu-0u9QwV_dNGBtHvR41x8ISUAeyzvdL1-OgXOBsV9PFIuqa_ySA
Message-ID: <CADnq5_OvNetbaR=EjSmDTV_UTBwK=y_kZkG+5rhqK7JrcmVTEg@mail.gmail.com>
Subject: Re: [v12 09/11] drm/amdgpu/userq: add a detect and reset callback
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

On Thu, Aug 28, 2025 at 5:24=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
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
> index 502fa0a40107..5fac18dfeca3 100644
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
> +                                                       drm_dev_wedged_ev=
ent(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
> +                                               }
> +                                       }
> +                               }
> +                       }
> +               }
> +       }

Either this function or the caller needs to make sure to take all of
the right locks for walking all of the queues.

Alex

> +
> +       return r;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>                                 struct drm_amdgpu_userq_in *args_in,
>                                 struct amdgpu_usermode_queue *queue)
> @@ -423,4 +471,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .map =3D mes_userq_map,
>         .preempt =3D mes_userq_preempt,
>         .restore =3D mes_userq_restore,
> +       .detect_and_reset =3D mes_userq_detect_and_reset,
>  };
> --
> 2.49.0
>
