Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C223BC44501
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5431D10E60A;
	Wed,  8 Jul 2026 13:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EnYN97LV";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5B910E5FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 13:45:12 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2caa0551d8bso2624945ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 06:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783518312; cv=none;
 d=google.com; s=arc-20260327;
 b=sxpQcNuJQnO+JYwoX4YQpZNVA+zIhvqdCW6NUEjLc0kesJQoMAtX8XelBV+gBji2pP
 6T49TRiJ5gwKzEQc8CeMnOefx+B7fXAHZE3iTh49SsOtxSAgjAeM3eByUl3iRO77sqNu
 AnBMK+Eh+0C3KSOQPnQoG4dmKa44oqrAyZHl965zwYNXY8wCgPOKdT3diDjMeveYC41B
 ofIZQa2z69BAwWjQ5rlwSU6Jz67tz5mYPbTVwCP0A0wMygAqV4VkXwU5qiURXRj9JAGS
 00bN3Nq9uc6yZ6tdSkMsq5fvwSnEs8+F1+3V/b17PacMSpwosMN9pFCe/6eR1Jy74s4A
 hWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HwiQN+ryzN4/zjOcZQGSXPZItUEbTdFtTzTPRd87xhg=;
 fh=BJAqlRfvMCtYI+D79GzXg6fcLv5eVizEO9Yg83744MA=;
 b=V97z4tZ5r6CWOBTEqnNvpfazf7TCPIFHQjpTqbmxxQUfEw1f97nUoEOixZ/mDkcLAk
 CKoLgvcQfVs0PvV8ookOnRy2JFEuzvHLd976CxZV11BiUDCUQo5crAtyq/FO0Zf2Sapt
 uCEhs+X68Ka1ZpxAKA2Ir/dFrq7KowlGqwTiPWQd4PlFQMwbIDygrJj5iJqEDjdGxvIr
 ARhdRp8ppTsF1p69RBv/XPVmpVmu2MX9agTZ18xWE+7+grIajfBdYE5nwTaukRCTFo1f
 KwFmTkw9OCGMv2sgvsc4RNsZEfX7GYlsAfTilourzTrZ7Iw9Gz3uJMdpEmAvt2l5SmE4
 tMNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783518312; x=1784123112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HwiQN+ryzN4/zjOcZQGSXPZItUEbTdFtTzTPRd87xhg=;
 b=EnYN97LVi2qS9c/um3QJMoYYRvx6ZeMvtX1epzYy4OtuBjiMztCYFOmmNnEUCRKBQi
 uZFKedYBQ4ug0NvkEh2ni4p4Jyd5uMt5nXj+nvpwB0wJbOO3cpliMEDTEcAw2gxrH6zn
 WMs5/A+nApPa6zeymQSlHF/4CPM16Yd7eex+A3MBNGMv8yad0hgGrHIAcPuU1R/HPbkK
 SdKc6CvoAZmCFAGqPj3TUApDXXTAupn2svycqeJe6diClAd7j1I+PMMbk76A0kO+c+1Q
 ScFoXDROmpq1V2vS0o5+z8OefZ6LGJOG2LCcN1uRfC94edTE2Nf6DI4pcmL77wUuTT8x
 xJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783518312; x=1784123112;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HwiQN+ryzN4/zjOcZQGSXPZItUEbTdFtTzTPRd87xhg=;
 b=W58gtxS0tTIA/AsAbNAOhrLesEueaM37FPp60ZwjCZFaMe53S8c4v4l45ghfREloit
 u0FkG3HiXT5c1TeHFscxZqXgXSYMChswG/lm9+anKxiYtJYLqvTgAP9Fk2gpr3ecP9N/
 zoNZDD8pEPOE+gX4V/cJjB7Evorg0D5o49kB6lEFGfgt9FdqM6NV0SYZKeeTMbFdICVT
 6DSDONbiTnOFIxbesx35ZSFxb0VLrR7Y4c+4NINbA4erq0izUpaXqnZtl9Bblxkx/ZGP
 ah0BhX5LLs9P7/0meEUY3mM9mbaITiesLVBdn48caplb87RaWdzEjUXYaZgOH+gkL3/5
 /s5w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq95hrN4h2kgGnuvoI5gkDT/1iGkSPgaAzUzd3P7g17+uLw1j7WpZJlJTbCodq4TkVRW+irmrXO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrXVva/bwO+/URzxE23p/M18r50oVSih+F+/XKucPeHJ6YJLL9
 0R/5X9rYZdqwNJIu6hrKFXwFzIdARqFhaPqNyq9p48s3QqV1AUma2gBJZ7CLkwbv58peETvw0D9
 zHy5fg8GWtYu+LldmigvP/dduaTipuvoLdg==
X-Gm-Gg: AfdE7clp7K7eD5dnko7wcXSIV/CaYGN/Vg/uofm7Tck4hzb69XT7qSh9yhq/wQkFwQh
 /qlKuIrgdvYCT1hKwXUeF+jVPgPPwbx/TuEplBNAIg2NWDyetNZTDGe8wvtcv55dqw+3HpIpXRA
 Me3tbiAqzZKM/yvc5Ks72C7D5rNhiiNOt/wbOcHj1eEBn4Wl3P/WAIm927EUTVgIYQsM7v9mt7c
 S1Twk0VdEsw3jmjgEWDL8BpxlL4icV08UAwDh1NuEhY0LMk/HflxpQ774YppIGxks7OaIFK1Wnd
 XV8/UHVwQaBA4jul32X+HaxaNMpvlcG7kE2MymRgzxPnJ8Hpdc6a+lsEzuZqY+8pWhGAEA==
X-Received: by 2002:a17:903:3885:b0:2ca:d344:7743 with SMTP id
 d9443c01a7336-2ccea3954d4mr22026805ad.7.1783518311651; Wed, 08 Jul 2026
 06:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
In-Reply-To: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 09:44:59 -0400
X-Gm-Features: AVVi8CdSfJX6WvcsVVcSKTB43OU7p1LaepGUMqXwpltlrDDoVgQBxAgCeqBCGMw
Message-ID: <CADnq5_Pq8ZZQXtSQ0YLp+1=i0Yvzn2o-rLN8ZCTU7xfEzmKwaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix DM IRQ teardown races
To: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>
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

On Mon, Jun 29, 2026 at 12:51=E2=80=AFPM Geoffrey McRae <geoffrey.mcrae@amd=
.com> wrote:
>
> DM IRQ teardown can race with interrupt handling and low-context work.
> The IRQ handler can still walk the DM IRQ handler tables while the
> teardown path removes and frees entries. Low-context work can also
> remain queued after its handler has been removed, leading to a possible
> use-after-free when the work item later runs.
>
> Add an irq_fini_in_progress flag and set it before the IRQ tables are
> torn down. Check the flag in the ISR and work scheduling paths so they
> do not access the handler tables or queue new work once teardown has
> started.
>
> Rework amdgpu_dm_irq_fini() to detach all low and high context handlers
> from the IRQ tables under the table lock, then cancel pending
> low-context work outside the lock before freeing the handlers. Also
> cancel low-context work in remove_irq_handler() before freeing an
> individual handler.
>
> Fix the suspend path by disabling HPD and HPD RX hardware interrupts
> under the IRQ table lock before flushing pending low-context work,
> avoiding a TOCTOU window where new work could be queued after the list
> check.
>
> Finally, call amdgpu_dm_irq_fini() from amdgpu_dm_fini() before DC is
> destroyed, so IRQ teardown happens while the display core state is still
> valid.
>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>

Series looks correct to me, but I'm not an expert on the display code.
So ideally we'd get some feedback from Harry or Leo.
Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 164 ++++++++++--------
>  3 files changed, 96 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b97ceabe6173..9c5e963337cc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1010,14 +1010,11 @@ static void amdgpu_dm_fini(struct amdgpu_device *=
adev)
>                 adev->dm.hpd_rx_offload_wq =3D NULL;
>         }
>
> +       amdgpu_dm_irq_fini(adev);
> +
>         /* DC Destroy TODO: Replace destroy DAL */
>         if (adev->dm.dc)
>                 dc_destroy(&adev->dm.dc);
> -       /*
> -        * TODO: pageflip, vlank interrupt
> -        *
> -        * amdgpu_dm_irq_fini(adev);
> -        */
>
>         if (adev->dm.cgs_device) {
>                 amdgpu_cgs_destroy_device(adev->dm.cgs_device);
> @@ -1523,7 +1520,6 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_bl=
ock)
>
>         amdgpu_dm_hpd_fini(adev);
>
> -       amdgpu_dm_irq_fini(adev);
>         amdgpu_dm_fini(adev);
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 909ee71d6d59..88687a7e01a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -340,6 +340,8 @@ struct hpd_rx_irq_offload_work {
>   * @dmcub_trace_event_en: enable dmcub trace events
>   * @dmub_outbox_params: DMUB Outbox parameters
>   * @num_of_edps: number of backlight eDPs
> + * @irq_fini_in_progress: Set during IRQ teardown to prevent interrupt h=
andlers
> + *                       from accessing the IRQ tables during cleanup
>   * @disable_hpd_irq: disables all HPD and HPD RX interrupt handling in t=
he
>   *                  driver when true
>   * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
> @@ -634,6 +636,7 @@ struct amdgpu_display_manager {
>          */
>         struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
>         bool force_timing_sync;
> +       bool irq_fini_in_progress;
>         bool disable_hpd_irq;
>         bool dmcub_trace_event_en;
>         /**
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index c5467f34c51f..3a5de9364ed1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -195,6 +195,9 @@ static struct list_head *remove_irq_handler(struct am=
dgpu_device *adev,
>                 return NULL;
>         }
>
> +       if (int_params->int_context =3D=3D INTERRUPT_LOW_IRQ_CONTEXT)
> +               cancel_work_sync(&handler->work);
> +
>         kfree(handler);
>
>         DRM_DEBUG_KMS(
> @@ -204,55 +207,6 @@ static struct list_head *remove_irq_handler(struct a=
mdgpu_device *adev,
>         return hnd_list;
>  }
>
> -/**
> - * unregister_all_irq_handlers() - Cleans up handlers from the DM IRQ ta=
ble
> - * @adev: The base driver device containing the DM device
> - *
> - * Go through low and high context IRQ tables and deallocate handlers.
> - */
> -static void unregister_all_irq_handlers(struct amdgpu_device *adev)
> -{
> -       struct list_head *hnd_list_low;
> -       struct list_head *hnd_list_high;
> -       struct list_head *entry, *tmp;
> -       struct amdgpu_dm_irq_handler_data *handler;
> -       unsigned long irq_table_flags;
> -       int i;
> -
> -       DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
> -
> -       for (i =3D 0; i < DAL_IRQ_SOURCES_NUMBER; i++) {
> -               hnd_list_low =3D &adev->dm.irq_handler_list_low_tab[i];
> -               hnd_list_high =3D &adev->dm.irq_handler_list_high_tab[i];
> -
> -               list_for_each_safe(entry, tmp, hnd_list_low) {
> -
> -                       handler =3D list_entry(entry, struct amdgpu_dm_ir=
q_handler_data,
> -                                            list);
> -
> -                       if (handler =3D=3D NULL || handler->handler =3D=
=3D NULL)
> -                               continue;
> -
> -                       list_del(&handler->list);
> -                       kfree(handler);
> -               }
> -
> -               list_for_each_safe(entry, tmp, hnd_list_high) {
> -
> -                       handler =3D list_entry(entry, struct amdgpu_dm_ir=
q_handler_data,
> -                                            list);
> -
> -                       if (handler =3D=3D NULL || handler->handler =3D=
=3D NULL)
> -                               continue;
> -
> -                       list_del(&handler->list);
> -                       kfree(handler);
> -               }
> -       }
> -
> -       DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
> -}
> -
>  static bool
>  validate_irq_registration_params(struct dc_interrupt_params *int_params,
>                                  void (*ih)(void *))
> @@ -459,38 +413,84 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_init);
>   * amdgpu_dm_irq_fini() - Tear down DM IRQ management
>   * @adev: The base driver device containing the DM device
>   *
> - * Flush all work within the low context IRQ table.
> + * Prevents any new interrupt handler scheduling, removes all handlers f=
rom
> + * the IRQ tables, cancels pending work items, and deallocates all handl=
er
> + * data. The irq_fini_in_progress flag ensures the ISR and work schedule=
r
> + * do not access the handler lists during teardown.
>   */
>  void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
>  {
>         int src;
> -       struct list_head *lh;
> +       LIST_HEAD(low_handlers);
> +       LIST_HEAD(high_handlers);
>         struct list_head *entry, *tmp;
>         struct amdgpu_dm_irq_handler_data *handler;
>         unsigned long irq_table_flags;
>
>         DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
> +
> +       /*
> +        * Set the fini flag before tearing down the IRQ tables. This ens=
ures
> +        * that any concurrent ISR (amdgpu_dm_irq_handler()) or work sche=
duler
> +        * (amdgpu_dm_irq_schedule_work()) will bail out early rather tha=
n
> +        * accessing handler data that is about to be freed.
> +        *
> +        * smp_store_release() pairs with the READ_ONCE() in the ISR and =
work
> +        * scheduler paths to guarantee visibility across CPUs.
> +        */
> +       smp_store_release(&adev->dm.irq_fini_in_progress, true);
> +
>         for (src =3D 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
>                 DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
> -               /* The handler was removed from the table,
> -                * it means it is safe to flush all the 'work'
> -                * (because no code can schedule a new one).
> +
> +               /*
> +                * Move all handlers from the low and high context tables=
 to
> +                * temporary lists under the lock. This prevents the ISR =
from
> +                * finding them while we process them outside the lock.
>                  */
> -               lh =3D &adev->dm.irq_handler_list_low_tab[src];
> +               list_splice_init(&adev->dm.irq_handler_list_low_tab[src],
> +                                &low_handlers);
> +               list_splice_init(&adev->dm.irq_handler_list_high_tab[src]=
,
> +                                &high_handlers);
> +
>                 DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>
> -               if (!list_empty(lh)) {
> -                       list_for_each_safe(entry, tmp, lh) {
> -                               handler =3D list_entry(
> -                                       entry,
> -                                       struct amdgpu_dm_irq_handler_data=
,
> -                                       list);
> -                               flush_work(&handler->work);
> -                       }
> +               /*
> +                * Cancel all pending work for the low-context handlers
> +                * outside the lock. cancel_work_sync() may sleep and wai=
ts
> +                * until any running work completes, preventing UAF.
> +                */
> +               list_for_each_safe(entry, tmp, &low_handlers) {
> +                       handler =3D list_entry(entry,
> +                                           struct amdgpu_dm_irq_handler_=
data,
> +                                           list);
> +                       cancel_work_sync(&handler->work);
>                 }
> +
> +               /*
> +                * High-context handlers are executed synchronously withi=
n ISR
> +                * context (see amdgpu_dm_irq_immediate_work()) and have =
no
> +                * work_struct, so there is no pending work to cancel her=
e.
> +                * They will be freed along with low_handlers after the l=
oop.
> +                */
> +       }
> +
> +       /* Deallocate all handlers. */
> +       list_for_each_safe(entry, tmp, &low_handlers) {
> +               handler =3D list_entry(entry,
> +                                    struct amdgpu_dm_irq_handler_data,
> +                                    list);
> +               list_del(&handler->list);
> +               kfree(handler);
> +       }
> +
> +       list_for_each_safe(entry, tmp, &high_handlers) {
> +               handler =3D list_entry(entry,
> +                                    struct amdgpu_dm_irq_handler_data,
> +                                    list);
> +               list_del(&handler->list);
> +               kfree(handler);
>         }
> -       /* Deallocate handlers from the table. */
> -       unregister_all_irq_handlers(adev);
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);
>
> @@ -498,7 +498,6 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev=
)
>  {
>         struct drm_device *dev =3D adev_to_drm(adev);
>         int src;
> -       struct list_head *hnd_list_h;
>         struct list_head *hnd_list_l;
>         unsigned long irq_table_flags;
>         struct list_head *entry, *tmp;
> @@ -511,12 +510,15 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *ad=
ev)
>         /**
>          * Disable HW interrupt  for HPD and HPDRX only since FLIP and VB=
LANK
>          * will be disabled from manage_dm_interrupts on disable CRTC.
> +        *
> +        * Disable the HW interrupt first, then flush any pending work. S=
ince
> +        * the HW interrupt is disabled under the lock, no new IRQ can be
> +        * generated after the disable completes. Any work already queued=
 by an
> +        * in-flight ISR will be flushed below.
>          */
>         for (src =3D DC_IRQ_SOURCE_HPD1; src <=3D DC_IRQ_SOURCE_HPD6RX; s=
rc++) {
>                 hnd_list_l =3D &adev->dm.irq_handler_list_low_tab[src];
> -               hnd_list_h =3D &adev->dm.irq_handler_list_high_tab[src];
> -               if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
> -                       dc_interrupt_set(adev->dm.dc, src, false);
> +               dc_interrupt_set(adev->dm.dc, src, false);
>
>                 DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>
> @@ -597,10 +599,20 @@ static void amdgpu_dm_irq_schedule_work(struct amdg=
pu_device *adev,
>         struct  list_head *handler_list =3D &adev->dm.irq_handler_list_lo=
w_tab[irq_source];
>         struct  amdgpu_dm_irq_handler_data *handler_data;
>         bool    work_queued =3D false;
> +       unsigned long irq_table_flags;
>
> -       if (list_empty(handler_list))
> +       /*perform a lockless check first*/
> +       if (READ_ONCE(adev->dm.irq_fini_in_progress))
>                 return;
>
> +       DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
> +
> +       if (READ_ONCE(adev->dm.irq_fini_in_progress))
> +               goto out_unlock;
> +
> +       if (list_empty(handler_list))
> +               goto out_unlock;
> +
>         list_for_each_entry(handler_data, handler_list, list) {
>                 if (queue_work(system_highpri_wq, &handler_data->work)) {
>                         work_queued =3D true;
> @@ -617,7 +629,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu=
_device *adev,
>                 handler_data_add =3D kzalloc(sizeof(*handler_data), GFP_A=
TOMIC);
>                 if (!handler_data_add) {
>                         DRM_ERROR("DM_IRQ: failed to allocate irq handler=
!\n");
> -                       return;
> +                       goto out_unlock;
>                 }
>
>                 /*copy new amdgpu_dm_irq_handler_data members from handle=
r_data*/
> @@ -639,6 +651,9 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu=
_device *adev,
>                                   "from display for IRQ source %d\n",
>                                   irq_source);
>         }
> +
> +out_unlock:
> +       DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>  }
>
>  /*
> @@ -678,9 +693,12 @@ static int amdgpu_dm_irq_handler(struct amdgpu_devic=
e *adev,
>                                  struct amdgpu_irq_src *source,
>                                  struct amdgpu_iv_entry *entry)
>  {
> +       enum dc_irq_source src;
> +
> +       if (READ_ONCE(adev->dm.irq_fini_in_progress))
> +               return 0;
>
> -       enum dc_irq_source src =3D
> -               dc_interrupt_to_irq_source(
> +       src =3D dc_interrupt_to_irq_source(
>                         adev->dm.dc,
>                         entry->src_id,
>                         entry->src_data[0]);
> --
> 2.43.0
>
