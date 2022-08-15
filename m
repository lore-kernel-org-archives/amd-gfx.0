Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23423C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 16:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A05BCA11;
	Wed, 24 Aug 2022 16:57:36 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB1412A11C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 14:21:45 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id c185so8715926oia.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=uaTYe9PliYSAimx5WaPpE8t9m2pmil7j7JfXxitdH/E=;
 b=DTjAQksBtQ70eldEbO6ifWYYMxqFuIQjgOZSBYOhHk6X1wLf6mJUJ5piynuOa55vvE
 oRPvNRW9Sb4Kj9AOeWh0J6SCH87gs+Z52ZNLK05cmAynY9MuFhaOxqoazsmVSBdVQ7AH
 kBKDiq8ZRdu+wNyFGCVnWvBJYXLEM0yULSdS404ZmDMLSNmUey9wMlwgoQ3wH5oLDrL3
 ujPQiSiPjKO7Iip7bkqM1oKQpvINfXqMlFtyOVk38vx3/uAY/s3jhvTtpXfEW3ijNkVw
 I0KU0w6Wabl0/SNqpP7Dd2wr9NvpGqnXF6zcLmPbzHNDD3fn/hJ2+hxBRT+n6T17CqbN
 MYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=uaTYe9PliYSAimx5WaPpE8t9m2pmil7j7JfXxitdH/E=;
 b=kU8YhtW9xRaUDjyX5T9sRwSiBJdRrJV7KnHq8U+MHT9gKcOWmohcsc9L5cSV/0XvfO
 oOgAx7Pxe/oswWk4lBa2HhAyG1TMaUccQtPIWbEbs74Vv7bGlROTNxyAF4/d/9Cecz8n
 MmZ/r378hQENowWSIPLznm1T81x2P2asGUMFgKfc1bKrO2Fi8BGA2BtT+0b4IvDT4iK5
 bFjdoH9iY4VUyGjdbwajyifE5tGEgHXkwOGCwOlfKqwAnYzX+Dmm3b+2+qXIOv3ZlnCX
 hXGmsL1W+z25UOXTMUShlz9RSHVy/q+QFp8MFmpC0jBjwgYa6fAeTBIPafvFJ8xU2Wf2
 kytg==
X-Gm-Message-State: ACgBeo0hg/58KIKmBbmMr0l73qAnbQCHVqFvmnckYV01Giy46LGmEpu8
 ETkvm4X3BLPJgetxQ3T9u2BnoMO91IlgRNTv9K0=
X-Google-Smtp-Source: AA6agR7yTRw04AsJRf6WWXrhLxueTUAYBdnIO7oqtEV8Z1YNTf6TcT3OUalDAx5X9ThaSsujG4FpE6Q9vRBQuUmj4x4=
X-Received: by 2002:a05:6808:1491:b0:343:7543:1a37 with SMTP id
 e17-20020a056808149100b0034375431a37mr6150642oiw.106.1660573304854; Mon, 15
 Aug 2022 07:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815070512.452430-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220815070512.452430-1-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Aug 2022 10:21:33 -0400
Message-ID: <CADnq5_NLzjD+4q0vF8n8JRaOf3iiGYoNN+W9K3FPLEP+_FHjUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
To: YiPeng Chai <YiPeng.Chai@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: yipechai@amd.com, Guchun.Chen@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 15, 2022 at 3:06 AM YiPeng Chai <YiPeng.Chai@amd.com> wrote:
>
> The psp_cmd_submit_buf function is called by psp_hw_fini to
> send TA unload messages to psp to terminate ras, asd and tmr.
> But when amdgpu is uninstalled, drm_dev_unplug is called
> earlier than psp_hw_fini in amdgpu_pci_remove, the calling
> order as follows:
> static void amdgpu_pci_remove(struct pci_dev *pdev)
> {
>         drm_dev_unplug
>         ......
>         amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
>                 ->.hw_fini->psp_hw_fini->...
>                 ->psp_ta_unload->psp_cmd_submit_buf
>         ......
> }
> The program will return when calling drm_dev_enter in
> psp_cmd_submit_buf.
>
> So the call to drm_dev_enter in psp_cmd_submit_buf should
> be removed, so that the TA unload messages can be sent to the
> psp when amdgpu is uninstalled.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b067ce45d226..0578d8d094a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -585,9 +585,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
>         if (psp->adev->no_hw_access)
>                 return 0;
>
> -       if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
> -               return 0;
> -

This check is to prevent the hardware from being accessed if the card
is removed.  I think we need to fix the ordering elsewhere.

Alex

>         memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>
>         memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
> @@ -651,7 +648,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
>         }
>
>  exit:
> -       drm_dev_exit(idx);
>         return ret;
>  }
>
> --
> 2.25.1
>
